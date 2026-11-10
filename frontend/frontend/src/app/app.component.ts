import { Component } from '@angular/core';
import { RouterLink, RouterOutlet } from '@angular/router';
import { IonApp, IonRouterOutlet, IonMenu, IonHeader,IonToolbar,IonTitle,IonContent,IonList,IonItem,IonIcon,IonLabel,IonMenuToggle } from '@ionic/angular';
import { addIcons } from 'ionicons';
import { homeOutline, calendarOutline, ticketOutline, calendar } from 'ionicons/icons';

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  imports: [RouterLink, RouterOutlet, IonApp, IonRouterOutlet, IonMenu, IonHeader,IonToolbar,IonTitle,IonContent,IonList,IonItem,IonIcon,IonLabel,IonMenuToggle ],
})
export class AppComponent {
  constructor() {
    addIcons({ homeOutline, calendarOutline, ticketOutline});
  }
}
