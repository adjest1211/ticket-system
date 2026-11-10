
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Router, RouterLink } from '@angular/router';

import {
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonCard,
  IonCardHeader,
  IonCardTitle,
  IonCardContent,
  IonGrid,
  IonRow,
  IonCol,
  IonButton,
  IonButtons
} from '@ionic/angular';

import { AuthService } from '../../services/auth';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.page.html',
  styleUrls: ['./dashboard.page.scss'],
  standalone: true,
  imports: [
    CommonModule,
    RouterLink,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonCard,
    IonCardHeader,
    IonCardTitle,
    IonCardContent,
    IonGrid,
    IonRow,
    IonCol,
    IonButton,
    IonButtons
  ]
})
export class DashboardPage implements OnInit {

  dashboard = {
    totalEvents: 0,
    totalBookings: 0,
    totalUsers: 0,
    confirmedTickets: 0
  };

  constructor(
    private http: HttpClient,
    private authService: AuthService,
    private router: Router
  ) {}

  ngOnInit() {
    this.loadDashboard();
  }

  // LOAD DASHBOARD STATISTICS
  loadDashboard() {

    this.http.get<any>('http://127.0.0.1:8000/dashboard')
      .subscribe({

        next: (response) => {
          this.dashboard = response;
        },

        error: (error) => {
          console.error('Dashboard loading error:', error);
        }

      });

  }

  // LOGOUT
  logout() {

    this.authService.logout();

    this.router.navigateByUrl('/login');

  }

}
