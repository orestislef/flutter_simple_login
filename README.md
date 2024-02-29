# Flutter Simple Login App

This Flutter application provides a simple login functionality with integration for Google, Facebook, and Apple sign-in methods. It is designed to work across multiple platforms including Android, iOS, Windows, and web.

## Features

- **Google Sign-In:** Users can authenticate using their Google account credentials.
- **Facebook Sign-In:** Users can authenticate using their Facebook account credentials.
- **Apple Sign-In:** Users can authenticate using their Apple account credentials.

## Getting Started

To run this application on your local machine, follow these steps:

1. Clone this repository:

    ```bash
    git clone https://github.com/orestislef/Breadcrumbsflutter_simple_login.git
    ```

2. Navigate to the project directory:

    ```bash
    cd your-flutter-app
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app:

    ```bash
    flutter run
    ```

## Configuration

### Firebase Setup

If you're using Firebase for authentication, follow these steps:

1. Create a new project in the [Firebase Console](https://console.firebase.google.com/).
2. Add your Flutter app to the Firebase project.
3. Download the `google-services.json` file (for Android) and `GoogleService-Info.plist` file (for iOS) and place them in the appropriate directories (`android/app` and `ios/Runner`, respectively).
4. Enable Google, Facebook, and Apple sign-in methods in the Firebase Authentication settings.

### Facebook Setup

If you're using Facebook for authentication, follow these steps:

1. Create a new app in the [Facebook Developer Dashboard](https://developers.facebook.com/apps/).
2. Configure the app with the necessary details.
3. Retrieve your Facebook App ID and App Secret.
4. Add your Flutter app to the Facebook app settings.
5. Follow the necessary steps to set up Facebook authentication in your Flutter app using the `flutter_facebook_auth` plugin.

### Apple Setup

If you're using Apple for authentication, follow these steps:

1. Register your app in the [Apple Developer Console](https://developer.apple.com/account/resources/identifiers/list).
2. Generate an Apple Services ID and configure it with your app.
3. Add Sign in with Apple capability to your Xcode project.
4. Follow the necessary steps to set up Apple authentication in your Flutter app using the `flutter_apple_sign_in` plugin.

## Contributing

Contributions are welcome! If you find any bugs or have suggestions for improvement, please open an issue or create a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
