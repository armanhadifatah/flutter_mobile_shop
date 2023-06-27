# Phone Store

Phone Store is a Flutter application that leverages Firebase for phone authentication, Riverpod for state management, Hive for local storage, and Build Runner for Riverpod code generation.

## Table of Contents

- [Getting Started](#getting-started)
- [Project Setup](#project-setup)
- [Firebase Setup](#firebase-setup)
- [Hive Setup](#hive-setup)
- [Usage](#usage)
- [Running the App](#running-the-app)
- [Contributing](#contributing)
- [Contact](#contact)
- [License](#license)

## Getting Started

If you are new to Flutter, please see the [Flutter documentation](https://flutter.dev/docs) to get started.

## Project Setup

To setup the project on your local machine, please follow these instructions:

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/flutter_mobile_shop.git
   ```
2. Navigate to the project directory:
   ```
   cd flutter_mobile_shop
   ```
3. Get Flutter packages:
   ```
   flutter pub get
   ```
4. Generate the Riverpod code:
   ```
   flutter packages pub run build_runner build
   ```

## Firebase Setup

To setup Firebase:

1. Create a new project on the [Firebase Console](https://console.firebase.google.com).
2. Follow the instructions to integrate Firebase with your Android and iOS projects.
3. Enable phone authentication in your Firebase project by navigating to `Develop -> Authentication -> Sign-in Method -> Phone`.
4. Download your Firebase configuration files, `GoogleService-Info.plist` for iOS and `google-services.json` for Android, and place them in the respective directories.

\*Note please do not forget to add your SH1 key to firebase.

## Hive Setup

Hive is a lightweight and blazingly fast key-value database written in pure Dart. No additional setup is required for Hive.

## Usage

This project uses Riverpod for its state management. Each feature or functionality of the application that requires state management is isolated into its own "provider".

Phone authentication via Firebase has been integrated into this application. Users can authenticate themselves using their phone numbers.

Data persistence is achieved using Hive. Data is stored locally and can be retrieved even when the app is offline or restarted.

## Running the App

To run the app, navigate to the project's root directory and run:

```bash
flutter run
```
