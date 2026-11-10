import { Routes } from '@angular/router';

import { LoginPage } from './pages/login/login.page';
import { RegisterPage } from './pages/register/register.page';
import { CustomerHomePage } from './pages/customer-home/customer-home.page';
import { EventDetailsPage } from './pages/event-details/event-details.page';
import { MyBookingsPage } from './pages/my-bookings/my-bookings.page';
import { DashboardPage } from './pages/dashboard/dashboard.page';
import { EventsPage } from './pages/events/events.page';
import { EventFormPage } from './pages/event-form/event-form.page';
import { BookingsPage } from './pages/bookings/bookings.page';

export const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' },

  { path: 'login', component: LoginPage },
  { path: 'register', component: RegisterPage },

  { path: 'dashboard', component: DashboardPage },
  { path: 'events', component: EventsPage },
  { path: 'event-form', component: EventFormPage },
  { path: 'event-form/:id', component: EventFormPage },
  { path: 'bookings', component: BookingsPage },

  { path: 'customer-home', component: CustomerHomePage },
  { path: 'event-details/:id', component: EventDetailsPage },
  { path: 'my-bookings', component: MyBookingsPage },

  { path: '**', redirectTo: 'login' }
];
