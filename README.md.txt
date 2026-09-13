# Play School Management System

A mobile-based Play School Management System developed to simplify the management of children, parents, attendance, activities, and monthly fees through a single application.

## Project Overview

The Play School Management System is a Flutter-based application designed for play school administrators to manage day-to-day school activities.

The application uses **Flutter** for the frontend, **Node.js and Express.js** for the backend, and **MongoDB** for database management.

The Flutter application communicates with the backend through REST APIs. The backend handles business logic, validation, and database operations using Mongoose.

## Features

### Child Management

* Add new children
* View child details
* Edit child information
* Delete child records
* Store date of birth and gender
* Manage monthly fees

### Parent Management

* Add parent details
* Link parents with their child
* Store father and mother details
* Store phone number and email
* Store parent address
* Edit and delete parent records
* Prevent duplicate parent records

### Attendance Management

* Mark children as Present or Absent
* Record attendance by date
* View attendance history
* Prevent duplicate attendance records for the same child and date
* Display today's attendance statistics on the dashboard

### Activity Management

* Add school activities
* Display activities
* Store activity information
* Activity notifications for parents

### Fee Management

* Manage monthly school fees
* Automatically maintain Pending and Paid status
* Mark fees as Paid after payment
* Support online and offline payment status updates
* Generate fee acknowledgement notifications

### Dashboard

The dashboard provides a quick overview of:

* Total children
* Present children today
* Absent children today
* Total activities

Dashboard information is retrieved from the database through REST APIs.

## Technology Stack

### Frontend

* Flutter
* Dart
* REST API
* HTTP package

### Backend

* Node.js
* Express.js
* REST API
* Mongoose

### Database

* MongoDB
* MongoDB Atlas

### Development Tools

* Visual Studio Code
* Android Studio
* Git
* GitHub

## System Architecture

```text
Flutter Mobile Application
          |
          | HTTP / REST API
          v
Node.js + Express.js Backend
          |
          | Mongoose
          v
MongoDB Atlas
```

### Application Flow

```text
Admin
  |
  v
Flutter App
  |
  v
REST API
  |
  v
Express.js Server
  |
  v
Mongoose
  |
  v
MongoDB Atlas
  |
  v
Response
  |
  v
Flutter UI
```

## Project Structure

```text
playschool-management/
│
├── playschool_app/
│   ├── android/
│   ├── ios/
│   ├── lib/
│   │   ├── models/
│   │   ├── screens/
│   │   ├── services/
│   │   └── main.dart
│   ├── pubspec.yaml
│   └── ...
│
├── playschool_backend/
│   ├── models/
│   ├── routes/
│   ├── controllers/
│   ├── server.js
│   ├── package.json
│   └── ...
│
├── .gitignore
└── README.md
```

## Database Collections

The application uses MongoDB collections for storing application data.

### Children

Stores information such as:

* Child name
* Date of birth
* Gender
* Admission date
* Monthly fee

### Parents

Stores:

* Child ID
* Father's name
* Mother's name
* Phone number
* Email
* Address

### Attendance

Stores:

* Child ID
* Attendance date
* Attendance status

### Activities

Stores:

* Activity details
* Activity date
* Activity information

### Fees

Stores:

* Child ID
* Monthly fee
* Payment status
* Payment date

## REST API

The Flutter application communicates with the backend using REST APIs.

Example endpoints:

```text
GET    /api/children
POST   /api/children
PUT    /api/children/:id
DELETE /api/children/:id

GET    /api/parents
POST   /api/parents
PUT    /api/parents/:id
DELETE /api/parents/:id

POST   /api/attendance
GET    /api/attendance

GET    /api/activities
POST   /api/activities

GET    /api/fees
PUT    /api/fees/:id

GET    /api/dashboard
GET    /api/notifications
```

## Installation and Setup

### Prerequisites

Install the following:

* Flutter SDK
* Dart SDK
* Node.js
* MongoDB Atlas account
* Android Studio
* Visual Studio Code
* Git

### 1. Clone the Repository

```bash
git clone https://github.com/sanjith1265/playschool-management-system.git
```

Move into the project:

```bash
cd playschool-management-system
```

### 2. Setup Backend

```bash
cd playschool_backend
```

Install dependencies:

```bash
npm install
```

Create a `.env` file:

```env
MONGO_URI=your_mongodb_connection_string
PORT=5000
```

Start the backend:

```bash
node server.js
```

The backend should run on:

```text
http://localhost:5000
```

### 3. Setup Flutter Application

Open another terminal:

```bash
cd playschool_app
```

Install Flutter dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## Android Emulator Configuration

When running the Flutter application using the Android Studio emulator, `localhost` refers to the emulator itself.

Therefore, use:

```text
http://10.0.2.2:5000
```

as the backend URL.

For example:

```dart
static const String baseUrl = "http://10.0.2.2:5000";
```

When running the application on a physical Android device, use the computer's local network IP address instead.

Example:

```dart
static const String baseUrl = "http://192.168.1.10:5000";
```

Both the computer and phone must be connected to the same network.

## Security

Sensitive information should not be committed to GitHub.

The following files should remain private:

```text
.env
node_modules/
```

The MongoDB connection string should be stored in environment variables instead of directly inside the source code.

Example:

```env
MONGO_URI=your_private_connection_string
```

## Future Enhancements

Planned improvements include:

* Activity photo gallery
* Multiple photo uploads for activities
* Full-screen activity photo viewer
* Android release APK
* Role-based Admin and Parent login
* Push notifications
* Improved authentication and authorization
* Additional application security

## Project Goals

The main goals of the system are to:

* Reduce manual record keeping
* Simplify attendance management
* Maintain organized child and parent information
* Track monthly fee payments
* Provide activity updates
* Give administrators a centralized management application

## Contributors

**Sanjith**

B.Tech Computer Science and Engineering

SASTRA University

## License

This project was developed as an academic project.

You may modify and extend the project for educational purposes.
