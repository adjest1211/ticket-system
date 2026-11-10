
import { Component, OnInit } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import { RouterLink } from '@angular/router';

import {
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonCard,
  IonCardHeader,
  IonCardTitle,
  IonCardContent,
  IonButton,
  IonBadge
} from '@ionic/angular';

import { BookingService } from '../../services/booking';
import { AuthService } from '../../services/auth';

@Component({
  selector: 'app-my-bookings',
  standalone: true,
  templateUrl: './my-bookings.page.html',
  imports: [
    CommonModule,
    DatePipe,
    RouterLink,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonCard,
    IonCardHeader,
    IonCardTitle,
    IonCardContent,
    IonButton,
    IonBadge
  ]
})
export class MyBookingsPage implements OnInit {

  bookings: any[] = [];
  errorMessage = '';

  constructor(
    private bookingService: BookingService,
    private authService: AuthService
  ) {}

  ngOnInit() {
    this.loadBookings();
  }

  loadBookings() {
    const userId = this.authService.getUserId();

    if (!userId) {
      this.errorMessage = 'Please log in first.';
      return;
    }

    this.errorMessage = '';

    this.bookingService.getMyBookings(userId).subscribe({
      next: (response) => {
        this.bookings = response;
      },
      error: (error) => {
        console.error('Booking loading error:', error);
        this.errorMessage = 'Unable to load your bookings.';
      }
    });
  }

  cancelBooking(bookingId: number) {
    const confirmCancel = confirm(
      'Are you sure you want to cancel this booking?'
    );

    if (!confirmCancel) {
      return;
    }

    this.bookingService.updateBookingStatus(
      bookingId,
      'Cancelled'
    ).subscribe({
      next: () => {
        alert('Booking cancelled successfully!');
        this.loadBookings();
      },
      error: (error) => {
        console.error('Cancellation error:', error);
        alert(
          error.error?.detail || 'Unable to cancel booking.'
        );
      }
    });
  }

}
