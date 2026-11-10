
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';

import {
  IonContent,
  IonHeader,
  IonToolbar,
  IonTitle,
  IonButton,
  IonCard,
  IonCardHeader,
  IonCardTitle,
  IonCardContent,
  IonBadge
} from '@ionic/angular';

import { EventService } from '../../services/event';
import { AuthService } from '../../services/auth';

@Component({
  selector: 'app-customer-home',
  templateUrl: './customer-home.page.html',
  standalone: true,
  imports: [
    CommonModule,
    RouterLink,
    IonContent,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonButton,
    IonCard,
    IonCardHeader,
    IonCardTitle,
    IonCardContent,
    IonBadge,
  ]
})
export class CustomerHomePage implements OnInit {

  events: any[] = [];
  errorMessage = '';

  constructor(
    private eventService: EventService,
    private authService: AuthService,
    private router: Router
  ) {}

  ngOnInit() {
    this.loadEvents();
  }

  // LOAD EVENTS
  loadEvents() {

    this.errorMessage = '';

    this.eventService.getEvents().subscribe({

      next: (response) => {
        this.events = Array.isArray(response) ? response : [];
      },

      error: (error) => {
        console.error('Loading events failed:', error);

        this.errorMessage =
          error.error?.detail || 'Unable to load events.';

      }

    });

  }

  // VIEW EVENT DETAILS
  viewDetails(eventId: number) {
    this.router.navigate(['/event-details', eventId]);
  }

  // LOGOUT
  logout() {

    this.authService.logout();

    this.router.navigate(['/login']);

  }

}
