import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class MyGoogleSignIn {
  final GoogleSignInAccount googleSignInAccount;
  final GoogleSignInAuthentication googleSignInAuthentication;

  MyGoogleSignIn({
    required this.googleSignInAccount,
    required this.googleSignInAuthentication,
  });
}

class LoginHelper {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '246581804720-isuq7me6r4c41b1q1b4j069rghif225b.apps.googleusercontent.com',
  );

  static Future<MyGoogleSignIn?> loginWithGoogle() async {
    try {
      // Trigger Google Sign In
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      // Check if the sign-in process was canceled
      if (googleSignInAccount == null) {
        // Handle cancellation
        return null;
      }

      // Obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Successful login
      if (kDebugMode) {
        print("Logged in with Google successfully!");
      }
      return MyGoogleSignIn(
        googleSignInAccount: googleSignInAccount,
        googleSignInAuthentication: googleSignInAuthentication,
      );
    } catch (e) {
      // Handle errors
      if (kDebugMode) {
        print("Error during Google sign in: $e");
      }
      return null;
    }
  }

  static Future<AuthorizationCredentialAppleID?> loginWithApple() async {
    try {
      AuthorizationCredentialAppleID authorizationCredentialAppleID =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Successful login
      if (kDebugMode) {
        print("Logged in with Apple successfully!");
      }
      return authorizationCredentialAppleID;
    } catch (e) {
      // Handle errors
      if (kDebugMode) {
        print("Error during Apple sign in: $e");
      }
      return null;
    }
  }

  static Future<LoginResult?> loginWithFacebook() async {
    try {
      // Trigger Facebook Sign In
      if (kIsWeb) {
        await FacebookAuth.instance.webAndDesktopInitialize(
            appId: '1365719610250300', //TODO get it from facebook developer portal
            cookie: true,
            xfbml: true,
            version: 'v1.0'); //TODO get it from facebook developer portal
      }
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // you are logged in
        FacebookAuth.instance.getUserData().then((mappedJsonResult) =>
            debugPrint(mappedJsonResult
                .toString())); //TODO: remove debugPrint and make it into an Object to send with the result

        return result;
      } else {
        // cancel
        if (kDebugMode) {
          print(result);
        }
        return null;
      }
    } catch (e) {
      // Handle errors
      if (kDebugMode) {
        print("Error during Facebook sign in: $e");
      }
      return null;
    }
  }

  static Future<void> facebookLogOut() async {
    // log out
    await FacebookAuth.instance.logOut();
  }
}
