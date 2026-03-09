# KigaliPullup SETUP INSTRUCTIONS

Follow these steps to get the **Kigali City Services & Places Directory** running locally on your machine.

## Prerequisites

1.  **Flutter SDK** (v3.10.7 or higher recommended)
2.  **Android Studio** / Android SDK (for Android build)
3.  **Xcode** (if building for iOS on a Mac)

## 1. Clone the Repository

```bash
git clone <your-repo-url>
cd kigaliPullup/app
```

## 2. Install Dependencies

Ensure you are inside the `app/` directory, then run:

```bash
flutter pub get
```

## 3. Map Setup (OpenStreetMap)

The app uses `flutter_map` with OpenStreetMap tile layers, which means **no Google Maps API key is required**. The map will work out of the box as soon as you run the app!

## 4. Run the Application

Connect an emulator or physical device, then run:

```bash
flutter run
```

## 5. Seed Test Data (Development Only)

Once the app is running:
1.  Sign up for a new account in the app.
2.  Go to the **Settings** tab.
3.  Tap **"Seed Test Data — Dev Only"**.
4.  This will populate your Firestore database with 8 sample Kigali directory listings so you can see the App in action.
