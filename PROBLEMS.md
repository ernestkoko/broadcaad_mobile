# Problems Introduced in the Codebase

This file outlines the intentional bugs and issues introduced into the codebase for assessment purposes. Your task is to identify and fix these bugs.

## Problem 1: Incorrect Password Validation in `AuthBloc`

- **File**: `lib/blocs/auth/auth_bloc.dart`
- **Description**: In the `LoginEvent` handling, there is an incorrect password validation that throws an exception when the password length is greater than 4 characters, which is not the intended behavior.

## Problem 2: Firebase Configuration Error

- **File**: `main.dart`, `android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`
- **Description**: The Firebase configuration files are missing or incorrect, causing the app to fail when attempting to use Firebase services.

## Problem 3: Unhandled Network Errors

- **File**: `auth_repository.dart`
- **Description**: The app does not handle network connectivity issues. If the device is offline, the app crashes instead of showing an error message to the user.

## Problem 4: Missing Home Screen Navigation

- **File**: `login_screen.dart`
- **Description**: Upon successful login, the app does not navigate to the home screen because the home screen is not implemented.

