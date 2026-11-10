
import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';

import {
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonButton,
  IonItem,
  IonInput,
  IonTextarea,
  IonSelect,
  IonSelectOption,
  IonLabel,
  IonButtons,
  AlertController
} from '@ionic/angular';

import { EventService } from '../../services/event';

@Component({
  selector: 'app-event-form',
  standalone: true,
  templateUrl: './event-form.page.html',
  imports: [
    CommonModule,
    FormsModule,
    RouterLink,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonButton,
    IonItem,
    IonInput,
    IonTextarea,
    IonSelect,
    IonSelectOption,
    IonLabel,
    IonButtons
  ]
})
export class EventFormPage implements OnInit {

  private eventService = inject(EventService);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private alertController = inject(AlertController);

  eventId: number | null = null;
  isEditMode = false;

  event = {
    eventName: '',
    description: '',
    venue: '',
    startDateTime: '',
    endDateTime: '',
    ticketPrice: 0,
    availableTickets: 0,
    status: 'Upcoming'
  };

  ngOnInit() {

    const id = this.route.snapshot.paramMap.get('id');

    if (id) {
      this.eventId = Number(id);
      this.isEditMode = true;
      this.loadEvent(this.eventId);
    }

  }

  loadEvent(id: number) {


    this.eventService.getEvent(id).subscribe({
      next: (data: any) => {

        this.event = {
          eventName: data.eventName,
          description: data.description,
          venue: data.venue,
          startDateTime: this.toDateTimeLocal(data.startDateTime),
          endDateTime: this.toDateTimeLocal(data.endDateTime),
          ticketPrice: Number(data.ticketPrice),
          availableTickets: Number(data.availableTickets),
          status: data.status
        };

      },
      error: (err: any) => {
        console.error('Error loading event:', err);
        this.showAlert('Error', 'Unable to load event information.');
      }
    });

  }

  toDateTimeLocal(value: string): string {

    if (!value) {
      return '';
    }

    const date = new Date(value);
    const offset = date.getTimezoneOffset();

    const localDate = new Date(date.getTime() - offset * 60000);

    return localDate.toISOString().slice(0, 16);
  }

  async saveEvent() {

    if (
      !this.event.eventName ||
      !this.event.venue ||
      !this.event.startDateTime ||
      !this.event.endDateTime
    ) {
      this.showAlert('Validation Error', 'Please complete all required fields.');
      return;
    }

    if (new Date(this.event.endDateTime) <= new Date(this.event.startDateTime)) {
      this.showAlert('Invalid Date', 'The end date and time must be after the start date and time.');
      return;
    }

    if (this.event.ticketPrice < 0 || this.event.availableTickets < 0) {
      this.showAlert('Invalid Input', 'Ticket price and available tickets cannot be negative.');
      return;
    }


    const data = {
      ...this.event,
      ticketPrice: Number(this.event.ticketPrice),
      availableTickets: Number(this.event.availableTickets)
    };

    if (this.isEditMode && this.eventId !== null) {

      this.eventService.updateEvent(this.eventId, data).subscribe({
        next: () => {
            this.showAlert('Success', 'Event updated successfully.');
          this.router.navigate(['/events']);
        },
        error: (err: any) => {
            console.error('Error updating event:', err);
          this.showAlert(
            'Update Failed',
            err.error?.detail || 'Unable to update event.'
          );
        }
      });

    } else {

      this.eventService.addEvent(data).subscribe({
        next: () => {
            this.showAlert('Success', 'Event added successfully.');
          this.router.navigate(['/events']);
        },
        error: (err: any) => {
            console.error('Error adding event:', err);
          this.showAlert(
            'Add Failed',
            err.error?.detail || 'Unable to add event.'
          );
        }
      });

    }

  }

  async showAlert(header: string, message: string) {

    const alert = await this.alertController.create({
      header,
      message,
      buttons: ['OK']
    });

    await alert.present();
  }

}
