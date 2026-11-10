
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BookingService {

  private apiUrl = 'http://127.0.0.1:8000';

  constructor(private http: HttpClient) {}

  // ADD BOOKING
  addBooking(data: any): Observable<any> {
    return this.http.post(
      `${this.apiUrl}/bookings`,
      data
    );
  }

  // GET ALL BOOKINGS (ADMIN)
  getBookings(): Observable<any> {
    return this.http.get(
      `${this.apiUrl}/bookings`
    );
  }

  // GET ONE BOOKING
  getBooking(id: number): Observable<any> {
    return this.http.get(
      `${this.apiUrl}/bookings/${id}`
    );
  }

  // GET CUSTOMER BOOKINGS
  getMyBookings(userId: number): Observable<any> {
    return this.http.get(
      `${this.apiUrl}/customer/bookings/${userId}`
    );
  }

  // UPDATE BOOKING STATUS (ADMIN)
  updateBookingStatus(id: number, status: string): Observable<any> {
    return this.http.put(
      `${this.apiUrl}/bookings/${id}/status`,
      { status: status }
    );
  }

  // DELETE BOOKING (ADMIN)
  deleteBooking(id: number): Observable<any> {
    return this.http.delete(
      `${this.apiUrl}/bookings/${id}`
    );
  }

}
