import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';

export const authGuard: CanActivateFn = (route) => {

  const router = inject(Router);

  const token = localStorage.getItem('token');
  const role = localStorage.getItem('role');

  const expectedRole = route.data['role'];

  if (!token) {
    router.navigate(['/login']);
    return false;
  }

  if (expectedRole && role !== expectedRole) {
    router.navigate(
      [role === 'admin' ? '/dashboard' : '/customer-home']
    );
    return false;
  }

  return true;
};