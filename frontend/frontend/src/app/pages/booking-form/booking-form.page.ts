
import { Component, OnInit, inject } from '@angular/core';
import { Router } from '@angular/router';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';

import {
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonItem,
  IonInput,
  IonButton
} from '@ionic/angular';

import { BookingService } from '../../services/booking';

@Component({
  selector: 'app-booking-form',
  standalone: true,
  templateUrl: './booking-form.page.html',
  imports: [
    ReactiveFormsModule,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonItem,
    IonInput,
    IonButton
  ]
})
export class BookingFormPage {

  private fb = inject(FormBuilder);
  private service = inject(BookingService);
  private router = inject(Router);

  form = this.fb.group({
    userId: [1, [Validators.required, Validators.min(1)]],
    eventId: [null as number | null, [Validators.required, Validators.min(1)]],
    quantity: [1, [Validators.required, Validators.min(1)]]
  });

  addBooking() {

    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    const data = this.form.getRawValue() as {
      userId: number;
      eventId: number;
      quantity: number;
    };

    this.service.addBooking(data).subscribe({
      next: response => {
        alert(
          'Booking successful!\n' +
          'Booking ID: ' + response.bookingId +
          '\nTotal: ₱' + response.totalAmount +
          '\nStatus: ' + response.status
        );

        this.router.navigate(['/bookings']);
      },
      error: err => {
        alert(err.error?.detail || 'Unable to create booking');
      }
    });
  }

}
