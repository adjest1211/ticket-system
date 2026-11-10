
import { Component, inject } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule, DatePipe } from '@angular/common';

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
  IonButtons,
  AlertController
} from '@ionic/angular';

import { EventService } from '../../services/event';

@Component({
  selector: 'app-events',
  standalone: true,
  templateUrl: './events.page.html',
  imports: [
    CommonModule,
    RouterLink,
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
    IonButtons
  ]
})
export class EventsPage {

  private eventService = inject(EventService);
  private alertController = inject(AlertController);

  events: any[] = [];

  ionViewWillEnter() {
    this.loadEvents();
  }

  // Load all events
  loadEvents() {
    this.eventService.getEvents().subscribe({
      next: (data: any) => {
        this.events = data;
      },
      error: (err: any) => {
        console.error('Error loading events:', err);
      }
    });
  }

  // Delete event
  async deleteEvent(id: number) {

    const alert = await this.alertController.create({
      header: 'Delete Event',
      message: 'Are you sure you want to delete this event?',

      buttons: [
        {
          text: 'Cancel',
          role: 'cancel'
        },
        {
          text: 'Delete',
          role: 'destructive',
          handler: () => {

            this.eventService.deleteEvent(id).subscribe({
              next: () => {
                this.loadEvents();
              },
              error: (err: any) => {
                console.error('Error deleting event:', err);
              }
            });

          }
        }
      ]
    });

    await alert.present();
  }

}
