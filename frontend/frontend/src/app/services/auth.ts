
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, tap } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  private apiUrl = 'http://127.0.0.1:8000/auth';

  constructor(private http: HttpClient) {}

  // REGISTER
  register(data: any): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/register`, {
      fullName: data.fullName,
      email: data.email,
      password: data.password
    });
  }

  // LOGIN
  login(data: any): Observable<any> {

    return this.http.post<any>(`${this.apiUrl}/login`, {
      identifier: data.identifier,
      password: data.password
    }).pipe(
      tap(response => {
        localStorage.setItem('token', response.token);
        localStorage.setItem('role', response.role);
        localStorage.setItem('user', JSON.stringify(response.user));
      })
    );

  }

  // LOGOUT
  logout(): void {

    const token = localStorage.getItem('token');

    localStorage.removeItem('token');
    localStorage.removeItem('role');
    localStorage.removeItem('user');

    if (token) {
      this.http.post(`${this.apiUrl}/logout`, null, {
        params: { token: token }
      }).subscribe({
        next: () => console.log('Logout successful'),
        error: error => console.error('Logout failed:', error)
      });
    }

  }

  // GET USER
  getUser(): any {
    const user = localStorage.getItem('user');

    return user ? JSON.parse(user) : null;
  }

  // GET ROLE
  getRole(): string | null {
    return localStorage.getItem('role');
  }

  // GET USER ID
  getUserId(): number | null {
    const user = this.getUser();

    return user ? user.userId : null;
  }

  // CHECK LOGIN
  isLoggedIn(): boolean {
    return !!localStorage.getItem('token');
  }

  // CHECK ADMIN
  isAdmin(): boolean {
    return this.getRole() === 'admin';
  }

  // CHECK CUSTOMER
  isCustomer(): boolean {
    return this.getRole() === 'customer';
  }

}
