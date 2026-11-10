
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class EventService {

  private apiUrl = 'http://127.0.0.1:8000';

  constructor(private http: HttpClient) {}

  // ADMIN EVENTS
  getEvents(): Observable<any> {
    return this.http.get(`${this.apiUrl}/events`);
  }

  // CUSTOMER EVENTS
  getCustomerEvents(): Observable<any> {
    return this.http.get(`${this.apiUrl}/customer/events`);
  }

  // SINGLE EVENT
  getEvent(id: number): Observable<any> {
    return this.http.get(`${this.apiUrl}/events/${id}`);
  }

  // ADD EVENT
  addEvent(data: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/events`, data);
  }

  // UPDATE EVENT
  updateEvent(id: number, data: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/events/${id}`, data);
  }

  // DELETE EVENT
  deleteEvent(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/events/${id}`);
  }

}
