from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field, EmailStr
import secrets
import hashlib
from datetime import datetime, timedelta
from decimal import Decimal
from typing import Optional
from database import get_connection
import hmac

app = FastAPI(title="Event Ticketing API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"]
)

class EventModel(BaseModel):
    eventName: str
    description: str
    venue: str
    startDateTime: datetime
    endDateTime: datetime
    ticketPrice: float
    availableTickets: int
    status: str

class BookingModel(BaseModel):
    userId: int
    eventId: int
    quantity: int = Field(gt=0)

class BookingStatusModel(BaseModel):
    status: str

class RegisterModel(BaseModel):
    fullName: str
    email: EmailStr
    password: str


class LoginModel(BaseModel):
    identifier: str
    password: str


class CustomerBookingModel(BaseModel):
    userId: int
    eventId: int
    quantity: int

def hash_password(password: str) -> str:
    salt = secrets.token_hex(16)

    hashed = hashlib.pbkdf2_hmac(
        'sha256',
        password.encode(),
        salt.encode(),
        100000
    ).hex()

    return f"{salt}${hashed}"


def verify_password(password: str, stored_password: str):
    # Support existing plaintext passwords in your users table.
    if stored_password == password:
        return True, True

    try:
        salt, old_hash = stored_password.split("$")

        new_hash = hashlib.pbkdf2_hmac(
            'sha256',
            password.encode(),
            salt.encode(),
            100000
        ).hex()

        return hmac.compare_digest(new_hash, old_hash), False

    except (ValueError, AttributeError):
        return False, False

@app.post("/auth/register")
def register(data: RegisterModel):

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        email = str(data.email).strip().lower()

        cursor.execute(
            "SELECT userId FROM users WHERE email = %s",
            (email,)
        )

        if cursor.fetchone():
            raise HTTPException(
                status_code=409,
                detail="Email already registered"
            )

        if len(data.password) < 6:
            raise HTTPException(
                status_code=400,
                detail="Password must contain at least 6 characters"
            )

        hashed = hash_password(data.password)

        cursor.execute(
            """
            INSERT INTO users (fullName, email, password)
            VALUES (%s, %s, %s)
            """,
            (data.fullName.strip(), email, hashed)
        )

        conn.commit()

        return {
            "message": "Registration successful"
        }

    finally:
        cursor.close()
        conn.close()


@app.post("/auth/login")
def login(data: LoginModel):

    identifier = data.identifier.strip()
    password = data.password

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:

        # ADMIN LOGIN
        if identifier.lower() == "admin" and password == "1234":

            user_id = None
            role = "admin"

            token = secrets.token_urlsafe(32)
            token_hash = hashlib.sha256(token.encode()).hexdigest()
            expires_at = datetime.now() + timedelta(hours=24)

            cursor.execute(
                """
                INSERT INTO auth_sessions
                (userId, role, tokenHash, expiresAt, token)
                VALUES (%s, %s, %s, %s, %s)
                """,
                (user_id, role, token_hash, expires_at, token)
            )

            conn.commit()

            return {
                "message": "Login successful",
                "token": token,
                "role": "admin",
                "user": {
                    "userId": None,
                    "fullName": "Administrator",
                    "email": "admin"
                }
            }

        # CUSTOMER LOGIN
        cursor.execute(
            """
            SELECT userId, fullName, email, password
            FROM users
            WHERE email = %s
            """,
            (identifier.lower(),)
        )

        user = cursor.fetchone()

        if not user:
            raise HTTPException(
                status_code=401,
                detail="Invalid email or password"
            )

        # VERIFY PASSWORD
        valid, plaintext = verify_password(
            password,
            user["password"]
        )

        if not valid:
            raise HTTPException(
                status_code=401,
                detail="Invalid email or password"
            )

        # UPGRADE OLD PLAINTEXT PASSWORD
        if plaintext:

            new_password = hash_password(password)

            cursor.execute(
                """
                UPDATE users
                SET password = %s
                WHERE userId = %s
                """,
                (new_password, user["userId"])
            )

        # GENERATE CUSTOMER SESSION
        token = secrets.token_urlsafe(32)
        token_hash = hashlib.sha256(token.encode()).hexdigest()
        expires_at = datetime.now() + timedelta(hours=24)

        cursor.execute(
            """
            INSERT INTO auth_sessions
            (userId, role, tokenHash, expiresAt, token)
            VALUES (%s, %s, %s, %s, %s)
            """,
            (
                user["userId"],
                "customer",
                token_hash,
                expires_at,
                token
            )
        )

        conn.commit()

        return {
            "message": "Login successful",
            "token": token,
            "role": "customer",
            "user": {
                "userId": user["userId"],
                "fullName": user["fullName"],
                "email": user["email"]
            }
        }

    finally:
        cursor.close()
        conn.close()


@app.get("/customer/events")
def get_customer_events():

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute(
            """
            SELECT *
            FROM events
            WHERE status = 'Upcoming'
            AND availableTickets > 0
            AND startDateTime > NOW()
            ORDER BY startDateTime ASC
            """
        )

        return cursor.fetchall()

    finally:
        cursor.close()
        conn.close()


@app.get("/customer/events/{event_id}")
def get_customer_event(event_id: int):

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute(
            """
            SELECT *
            FROM events
            WHERE eventId = %s
            AND status = 'Upcoming'
            AND availableTickets > 0
            AND startDateTime > NOW()
            """,
            (event_id,)
        )

        event = cursor.fetchone()

        if not event:
            raise HTTPException(
                status_code=404,
                detail="Event not found or unavailable"
            )

        return event

    finally:
        cursor.close()
        conn.close()

@app.post("/customer/bookings")
def add_customer_booking(data: CustomerBookingModel):

    if data.quantity <= 0:
        raise HTTPException(
            status_code=400,
            detail="Quantity must be greater than zero"
        )

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        # Check customer
        cursor.execute(
            "SELECT userId FROM users WHERE userId = %s",
            (data.userId,)
        )

        user = cursor.fetchone()

        if not user:
            raise HTTPException(
                status_code=404,
                detail="Customer not found"
            )

        # Lock event row while checking ticket availability
        cursor.execute(
            """
            SELECT *
            FROM events
            WHERE eventId = %s
            FOR UPDATE
            """,
            (data.eventId,)
        )

        event = cursor.fetchone()

        if not event:
            raise HTTPException(
                status_code=404,
                detail="Event not found"
            )

        if event["status"] != "Upcoming":
            raise HTTPException(
                status_code=400,
                detail="This event is not available for booking"
            )

        if event["startDateTime"] <= datetime.now():
            raise HTTPException(
                status_code=400,
                detail="This event has already started"
            )

        if data.quantity > event["availableTickets"]:
            raise HTTPException(
                status_code=400,
                detail="Not enough tickets available"
            )

        total_amount = float(event["ticketPrice"]) * data.quantity

        cursor.execute(
            """
            INSERT INTO bookings
            (userId, eventId, quantity, totalAmount, bookingDate, status)
            VALUES (%s, %s, %s, %s, NOW(), 'Pending')
            """,
            (
                data.userId,
                data.eventId,
                data.quantity,
                total_amount
            )
        )

        # Deduct available tickets
        cursor.execute(
            """
            UPDATE events
            SET availableTickets = availableTickets - %s
            WHERE eventId = %s
            """,
            (data.quantity, data.eventId)
        )

        conn.commit()

        return {
            "message": "Booking successful",
            "bookingId": cursor.lastrowid,
            "totalAmount": total_amount,
            "status": "Pending"
        }

    except Exception:
        conn.rollback()
        raise

    finally:
        cursor.close()
        conn.close()

@app.get("/customer/bookings/{user_id}")
def get_customer_bookings(user_id: int):

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute(
            """
            SELECT
                b.bookingId,
                b.userId,
                b.eventId,
                b.quantity,
                b.totalAmount,
                b.bookingDate,
                b.status,
                e.eventName,
                e.venue,
                e.startDateTime,
                e.endDateTime
            FROM bookings b
            INNER JOIN events e
            ON b.eventId = e.eventId
            WHERE b.userId = %s
            ORDER BY b.bookingDate DESC
            """,
            (user_id,)
        )

        return cursor.fetchall()

    finally:
        cursor.close()
        conn.close()

@app.put("/customer/bookings/{booking_id}/cancel")
def cancel_customer_booking(booking_id: int):

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute(
            """
            SELECT *
            FROM bookings
            WHERE bookingId = %s
            """,
            (booking_id,)
        )

        booking = cursor.fetchone()

        if not booking:
            raise HTTPException(
                status_code=404,
                detail="Booking not found"
            )

        if booking["status"] != "Pending":
            raise HTTPException(
                status_code=400,
                detail="Only pending bookings can be cancelled"
            )

        cursor.execute(
            """
            UPDATE bookings
            SET status = 'Cancelled'
            WHERE bookingId = %s
            """,
            (booking_id,)
        )

        cursor.execute(
            """
            UPDATE events
            SET availableTickets = availableTickets + %s
            WHERE eventId = %s
            """,
            (booking["quantity"], booking["eventId"])
        )

        conn.commit()

        return {
            "message": "Booking cancelled successfully"
        }

    except Exception:
        conn.rollback()
        raise

    finally:
        cursor.close()
        conn.close()

@app.get("/events")
def get_event():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM events ORDER BY eventId DESC")
    result = cursor.fetchall()

    cursor.close()
    conn.close()

    return result

#viewcertainevent
@app.get("/events/{eventId}")
def get_event(eventId: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM events WHERE eventId = %s", (eventId,)
    )

    result = cursor.fetchone()

    cursor.close()
    conn.close()

    if not result:
        raise HTTPException(404, "Event not found")

    return result

#addEvent
@app.post("/events")
def add_event(event: EventModel):

    if event.endDateTime <= event.startDateTime:
        raise HTTPException(
            status_code=400,
            detail="End time must be after start time"
        )

    if event.status not in [
        "Upcoming", "Ongoing", "Completed", "Cancelled"
    ]:
        raise HTTPException(
            status_code=400,
            detail="Invalid event status"
        )

    conn = get_connection()
    cursor = conn.cursor()

    try:
        cursor.execute(
            """
            INSERT INTO events (
                eventName,
                description,
                venue,
                startDateTime,
                endDateTime,
                ticketPrice,
                availableTickets,
                status
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """,
            (
                event.eventName,
                event.description,
                event.venue,
                event.startDateTime,
                event.endDateTime,
                event.ticketPrice,
                event.availableTickets,
                event.status
            )
        )

        conn.commit()

        new_id = cursor.lastrowid

        return {
            "message": "Event created successfully",
            "eventId": new_id
        }

    finally:
        cursor.close()
        conn.close()

#updateevent
@app.put("/events/{eventId}")
def update_event(eventId: int, event: EventModel):
    if event.endDateTime <= event.startDateTime:
        raise HTTPException(400, "Invalid event date")

    if event.status not in [
        "Upcoming", "Ongoing", "Completed", "Cancelled"
    ]:
         raise HTTPException(400, "Invalid event status")

    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute(
        "SELECT eventId FROM events WHERE eventId = %s",
        (eventId,)
    )

    if not cursor.fetchone():
        cursor.close()
        conn.close()
        raise HTTPException(404, "Event not found")

    cursor.execute("""
        UPDATE events SET
            eventName = %s,
            description = %s,
            venue = %s,
            startDateTime = %s,
            endDateTime = %s,
            ticketPrice = %s,
            availableTickets = %s,
            status = %s
        WHERE eventId = %s
    """, (
        event.eventName,
        event.description,
        event.venue,
        event.startDateTime,
        event.endDateTime,
        event.ticketPrice,
        event.availableTickets,
        event.status,
        eventId
    ))

    conn.commit()
    cursor.close()
    conn.close()

    return {"message": "Event updated successfully"}

@app.delete("/events/{eventId}")
def delete_event(eventId: int):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute(
        "SELECT COUNT(*) FROM bookings WHERE eventId = %s",
        (eventId,)
    )

    if cursor.fetchone()[0] > 0:
        cursor.close()
        conn.close()
        raise HTTPException(
            400,
            "Cannot delete event with existing bookings"
        )

    cursor.execute(
        "DELETE FROM events WHERE eventId = %s",
        (eventId,)
    )

    if cursor.rowcount == 0:
        cursor.close()
        conn.close()
        raise HTTPException(404, "Event not found")

    conn.commit()
    cursor.close()
    conn.close()

    return {"message": "Event deleted successfully"}

@app.get("/events/{event_id}")
def get_event(event_id: int):

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:

        cursor.execute(
            """
            SELECT
                eventId,
                eventName,
                description,
                venue,
                startDateTime,
                endDateTime,
                ticketPrice,
                availableTickets,
                status
            FROM events
            WHERE eventId = %s
            """,
            (event_id,)
        )

        event = cursor.fetchone()

        if not event:
            raise HTTPException(
                status_code=404,
                detail="Event not found"
            )

        return event

    finally:
        cursor.close()
        conn.close()

@app.get("/bookings")
def get_bookings():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT
            b.bookingId,
            b.userId,
            u.fullName,
            b.eventId,
            e.eventName,
            b.quantity,
            b.totalAmount,
            b.bookingDate,
            b.status
        FROM bookings b
        INNER JOIN users u ON b.userId = u.userId
        INNER JOIN events e ON b.eventId = e.eventId
        ORDER BY b.bookingId DESC
    """)

    result = cursor.fetchall()

    cursor.close()
    conn.close()

    return result


@app.get("/bookings/{bookingId}")
def get_booking(bookingId: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT * FROM bookings
        WHERE bookingId = %s
    """, (bookingId,))

    result = cursor.fetchone()

    cursor.close()
    conn.close()

    if not result:
        raise HTTPException(404, "Booking not found")

    return result


@app.post("/bookings")
def add_booking(booking: BookingModel):
    conn = get_connection()
    cursor = conn.cursor()

    try:
        conn.start_transaction()

        cursor.execute(
            "SELECT userId FROM users WHERE userId = %s",
            (booking.userId,)
        )

        if not cursor.fetchone():
            raise HTTPException(404, "User not found")

        cursor.execute("""
            SELECT ticketPrice, availableTickets, status
            FROM events
            WHERE eventId = %s
            FOR UPDATE
        """, (booking.eventId,))

        event = cursor.fetchone()

        if not event:
            raise HTTPException(404, "Event not found")

        ticket_price, available, event_status = event

        if event_status == "Cancelled":
            raise HTTPException(400, "Event is cancelled")

        if event_status != "Upcoming":
            raise HTTPException(400, "Event is not open for booking")

        if booking.quantity > available:
            raise HTTPException(400, "Not enough available tickets")

        total = ticket_price * booking.quantity

        cursor.execute("""
            INSERT INTO bookings (
                userId, eventId, quantity,
                totalAmount, status
            )
            VALUES (%s, %s, %s, %s, 'Pending')
        """, (
            booking.userId,
            booking.eventId,
            booking.quantity,
            total
        ))

        booking_id = cursor.lastrowid

        cursor.execute("""
            UPDATE events
            SET availableTickets = availableTickets - %s
            WHERE eventId = %s
        """, (booking.quantity, booking.eventId))

        conn.commit()

        return {
            "message": "Booking created successfully",
            "bookingId": booking_id,
            "totalAmount": str(total),
            "status": "Pending"
        }

    except Exception:
        conn.rollback()
        raise

    finally:
        cursor.close()
        conn.close()


@app.put("/bookings/{bookingId}/status")
def update_booking_status(
    bookingId: int,
    data: BookingStatusModel
):
    if data.status not in [
        "Pending", "Confirmed", "Cancelled"
    ]:
        raise HTTPException(400, "Invalid booking status")

    conn = get_connection()
    cursor = conn.cursor()

    try:
        conn.start_transaction()

        cursor.execute("""
            SELECT eventId, quantity, status
            FROM bookings
            WHERE bookingId = %s
            FOR UPDATE
        """, (bookingId,))

        booking = cursor.fetchone()

        if not booking:
            raise HTTPException(404, "Booking not found")

        event_id, quantity, old_status = booking

        if old_status == data.status:
            conn.commit()
            return {"message": "Booking status unchanged"}

        if old_status == "Cancelled":
            raise HTTPException(
                400, "Cancelled booking cannot be reactivated"
            )

        if data.status == "Cancelled":
            cursor.execute("""
                UPDATE events
                SET availableTickets = availableTickets + %s
                WHERE eventId = %s
            """, (quantity, event_id))

        cursor.execute("""
            UPDATE bookings
            SET status = %s
            WHERE bookingId = %s
        """, (data.status, bookingId))

        conn.commit()

        return {
            "message": "Booking status updated",
            "status": data.status
        }

    except Exception:
        conn.rollback()
        raise

    finally:
        cursor.close()
        conn.close()


@app.delete("/bookings/{bookingId}")
def delete_booking(bookingId: int):
    conn = get_connection()
    cursor = conn.cursor()

    try:
        conn.start_transaction()

        cursor.execute("""
            SELECT eventId, quantity, status
            FROM bookings
            WHERE bookingId = %s
            FOR UPDATE
        """, (bookingId,))

        booking = cursor.fetchone()

        if not booking:
            raise HTTPException(404, "Booking not found")

        event_id, quantity, status = booking

        if status != "Cancelled":
            cursor.execute("""
                UPDATE events
                SET availableTickets = availableTickets + %s
                WHERE eventId = %s
            """, (quantity, event_id))

        cursor.execute(
            "DELETE FROM bookings WHERE bookingId = %s",
            (bookingId,)
        )

        conn.commit()

        return {"message": "Booking deleted successfully"}

    except Exception:
        conn.rollback()
        raise

    finally:
        cursor.close()
        conn.close()


# =========================
# DASHBOARD
# =========================

@app.get("/dashboard")
def get_dashboard():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT
            (SELECT COUNT(*) FROM events) AS totalEvents,
            (SELECT COUNT(*) FROM bookings) AS totalBookings,
            (SELECT COUNT(*) FROM users) AS totalUsers,
            (
                SELECT COALESCE(SUM(quantity), 0)
                FROM bookings
                WHERE status = 'Confirmed'
            ) AS confirmedTickets
    """)

    result = cursor.fetchone()

    cursor.close()
    conn.close()

    return result

@app.post("/auth/logout")
def logout(token: str):

    conn = get_connection()
    cursor = conn.cursor()

    try:
        cursor.execute(
            "DELETE FROM auth_sessions WHERE token = %s",
            (token,)
        )

        conn.commit()

        return {
            "message": "Logged out successfully"
        }

    finally:
        cursor.close()
        conn.close()