# KigaliPullup

A Flutter mobile application serving as a **Kigali City Services & Places Directory**. 

This app allows residents and visitors to discover and manage public services, lifestyle locations, cafes, hospitals, and more across Kigali.

## Features
- **User Authentication**: Secure email/password login and signup via Firebase Auth.
- **Directory Browsing**: View listings with real-time updates from Cloud Firestore.
- **Search & Filter**: Quickly find places by name or predefined categories.
- **Interactive Maps**: View all locations on an OpenStreetMap interface (no Google API keys required).
- **Listing Management**: Authenticated users can create, edit, and delete their own directory listings.

## Getting Started

To clone this repository and run the app locally, please refer to the detailed instructions in **[setup.md](setup.md)**.

## Tech Stack
- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **State Management**: [Riverpod](https://riverpod.dev/)
- **Backend & Database**: [Firebase](https://firebase.google.com/) (Auth & Firestore)
- **Maps**: `flutter_map` (OpenStreetMap)
