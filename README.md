# databasey3

## Purpose
This project aims to design and implement a database management system that facilitates the management of:

- Mobile and broadband inventory  
- Service bookings  
- E-payments and eBills  
- User feedback and reviews  

The system supports various user roles (administrator, regular user) and provides functionality for users and administrators to interact with services, make bookings, process payments, and give feedback.

---

## What This Project Does
The system allows users to:

- View available mobile and broadband services  
- Make bookings for those services  
- Facilitate e-payments and manage eBill details  
- Provide feedback for services, including ratings and reviews  

It also allows administrators to:

- Generate reports on customer activity, booking trends, and payment history  

---

## Scope

### Key Specifications & Features

- **User Management:**  
  Account creation, different access levels (admin, user)

- **Inventory Management:**  
  Manage mobile and broadband services (plans, devices, speeds), track availability

- **Booking Management:**  
  Users can book services, check availability, and schedule callback requests

- **Payment System:**  
  ePayments and associated eBills for users

- **Feedback System:**  
  Users can submit ratings and written feedback

- **Reporting:**  
  Generate reports on customer usage, service trends, and user activity

---

## Views

- **PendingBookings:**  
  Shows a list of all bookings that are in the "pending" state (status = 0), including the booking ID, username, inventory name, and booking date.

- **AllPayments:**  
  Displays all payment details including payment ID, username, amount paid, payment date, and payment method.

- **CustomerFeedback:**  
  Presents customer feedback with username, feedback text, rating, and feedback date.

- **MonthlyBookingTrends:**  
  Displays total bookings made per month, grouped by `'YYYY-MM'`.

- **AvailableInventory:**  
  Shows all available inventory items where `inventoryAvailability = 1`, including inventory ID, name, and description.

---

## Stored Procedures

- **BookService**  
  Allows a user to book a service by inserting a new record into the Booking table with status = 0 (pending).  
  **Inputs:** `userID`, `inventoryID`

- **UpdateBookingStatus**  
  Updates the status of an existing booking.  
  **Inputs:** `bookingID`, `newStatus` (e.g., 1 for completed)

- **GetUserPayments**  
  Retrieves payment history for a specific user.  
  **Inputs:** `userID`  
  **Outputs:** payment ID, username, booking ID, amount, date, method

- **GetMonthlyBookingCount**  
  Returns the number of bookings made per month.  
  **Grouped by:** `'YYYY-MM'`

- **GetMonthlyEarnings**  
  Returns the total earnings from payments in a specific month.  
  **Input:** `yearMonth` (formatted as `'YYYY-MM'`)
