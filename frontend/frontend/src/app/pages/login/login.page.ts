
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';

import {
  IonContent,
  IonHeader,
  IonToolbar,
  IonTitle,
  IonItem,
  IonLabel,
  IonInput,
  IonButton,
  IonText
} from '@ionic/angular';

import { AuthService } from '../../services/auth';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterLink,
    IonContent,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonItem,
    IonLabel,
    IonInput,
    IonButton,
    IonText
  ]
})
export class LoginPage {

  username = '';
  email = '';
  password = '';
  loginType = 'customer';

  errorMessage = '';

  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  login() {

    this.errorMessage = '';

    // Prepare login information
    const data = {
      identifier: this.loginType === 'admin'
        ? this.username
        : this.email,
      password: this.password
    };

    // Send login request
    this.authService.login(data).subscribe({

      next: (response) => {

        if (response.role === 'admin') {
          this.router.navigate(['/dashboard']);
        }
        else if (response.role === 'customer') {
          this.router.navigate(['/customer-home']);
        }
        else {
          this.errorMessage = 'Unknown account role.';
        }

      },

      error: (error) => {

        console.error('Login error:', error);

        this.errorMessage =
          error.error?.detail ||
          'Invalid username/email or password.';

      }

    });

  }

}
