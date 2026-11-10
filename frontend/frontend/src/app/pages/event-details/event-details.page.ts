
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../services/auth';

import {
  IonContent,
  IonHeader,
  IonToolbar,
  IonTitle,
  IonButton,
  IonItem,
  IonInput,
  IonCard,
  IonCardHeader,
  IonCardTitle,
  IonCardContent,
  IonText
} from '@ionic/angular';

import { EventService } from '../../services/event';
import { BookingService } from '../../services/booking';

@Component({
  selector: 'app-event-details',
  templateUrl: './event-details.page.html',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterLink,
    IonContent,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonButton,
    IonItem,
    IonInput,
    IonCard,
    IonCardHeader,
    IonCardTitle,
    IonCardContent,
    IonText
  ]
})
export class EventDetailsPage implements OnInit {

  event: any = null;
  eventId = 0;
  quantity = 1;

  errorMessage = '';
  successMessage = '';

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private eventService: EventService,
    private bookingService: BookingService,
    private authService: AuthService
  ) {}

  ngOnInit() {
    this.eventId = Number(this.route.snapshot.paramMap.get('id'));

    if (!Number.isInteger(this.eventId) || this.eventId <= 0) {
      this.errorMessage = 'Invalid event ID.';
      return;
    }

    this.loadEvent();
  }

  loadEvent() {
    this.errorMessage = '';

    this.eventService.getEvent(this.eventId).subscribe({
      next: (response: any) => {
        this.event = response;
      },
      error: (error) => {
        console.error('Failed to load event:', error);
        this.event = null;
        this.errorMessage =
          error.error?.detail || 'Unable to load event.';
      }
    });
  }

  get totalAmount(): number {
    return Number(this.event?.ticketPrice || 0) *
           Number(this.quantity || 0);
  }

  bookTicket() {
    this.errorMessage = '';
    this.successMessage = '';

    if (!this.event) {
      this.errorMessage = 'Event information is unavailable.';
      return;
    }

    const userId = this.authService.getUserId();

    if (!userId) {
      this.errorMessage = 'Please log in before booking.';
      return;
    }

    const ticketQuantity = Number(this.quantity);

    if (!Number.isInteger(ticketQuantity) || ticketQuantity < 1) {
      this.errorMessage = 'Please enter a valid ticket quantity.';
      return;
    }

    if (this.event.status !== 'Upcoming') {
      this.errorMessage = 'Only upcoming events can be booked.';
      return;
    }

    if (ticketQuantity > Number(this.event.availableTickets)) {
      this.errorMessage = 'Not enough available tickets.';
      return;
    }

    const data = {
      userId: userId,
      eventId: this.eventId,
      quantity: ticketQuantity
    };

    this.bookingService.addBooking(data).subscribe({
      next: () => {
        this.successMessage = 'Booking submitted successfully!';

        this.router.navigate(['/my-bookings']);
      },
      error: (error) => {
        console.error('Booking error:', error);
        this.errorMessage =
          error.error?.detail || 'Booking failed.';
      }
    });
  }
}
