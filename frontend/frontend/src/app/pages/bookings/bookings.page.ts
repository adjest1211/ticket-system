
import { Component, inject } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import { RouterLink } from '@angular/router';

import {
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonButton,
  IonCard,
  IonCardHeader,
  IonCardTitle,
  IonCardContent,
  IonBadge,
  IonItem,
  IonLabel,
  IonSelect,
  IonSelectOption,
  IonButtons,
  AlertController
} from '@ionic/angular';

import { BookingService } from '../../services/booking';

@Component({
  selector: 'app-bookings',
  standalone: true,
  templateUrl: './bookings.page.html',
  imports: [
    CommonModule,
    DatePipe,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonButton,
    IonCard,
    IonCardHeader,
    IonCardTitle,
    IonCardContent,
    IonBadge,
    IonItem,
    IonLabel,
    IonSelect,
    IonSelectOption,
    IonButtons,
    RouterLink
  ]
})
export class BookingsPage {

  private bookingService = inject(BookingService);
  private alertController = inject(AlertController);

  bookings: any[] = [];

  ionViewWillEnter() {
    this.loadBookings();
  }

  loadBookings() {
    this.bookingService.getBookings().subscribe({
      next: (data: any) => {
        this.bookings = data;
      },
      error: (err: any) => {
        console.error('Error loading bookings:', err);
      }
    });
  }

  updateStatus(id: number, status: string) {

    this.bookingService.updateBookingStatus(id, status).subscribe({
      next: () => {
        this.loadBookings();
      },
      error: (err: any) => {
        console.error('Error updating booking:', err);
      }
    });

  }

  async deleteBooking(id: number) {

    const alert = await this.alertController.create({
      header: 'Delete Booking',
      message: 'Are you sure you want to delete this booking?',
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel'
        },
        {
          text: 'Delete',
          role: 'destructive',
          handler: () => {
            this.bookingService.deleteBooking(id).subscribe({
              next: () => {
                this.loadBookings();
              },
              error: (err: any) => {
                console.error('Error deleting booking:', err);
              }
            });
          }
        }
      ]
    });

    await alert.present();
  }

}
