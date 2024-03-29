import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:test_login/enums/auth_type.dart';
import 'package:test_login/models/facebook_response.dart';
import 'package:test_login/models/my_facebook_sign_in.dart';
import 'package:test_login/models/my_google_sign_in.dart';

class LoginHelper {
  static Future<dynamic> loginWithAuthType(AuthType authType) async {
    switch (authType) {
      case AuthType.none:
        return null;
      case AuthType.google:
        return loginWithGoogle();
      case AuthType.apple:
        return loginWithApple();
      case AuthType.facebook:
        return loginWithFacebook();
    }
  }

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '246581804720-isuq7me6r4c41b1q1b4j069rghif225b.apps.googleusercontent.com',
  );

  static Future<MyGoogleSignIn?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // Handle cancellation
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      if (kDebugMode) {
        print("Logged in with Google successfully!");
      }
      return MyGoogleSignIn(
        googleSignInAccount: googleSignInAccount,
        googleSignInAuthentication: googleSignInAuthentication,
      );
    } catch (e) {
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

      if (kDebugMode) {
        print("Logged in with Apple successfully!");
      }
      return authorizationCredentialAppleID;
    } catch (e) {
      if (kDebugMode) {
        print("Error during Apple sign in: $e");
      }
      return null;
    }
  }

  static Future<MyFacebookSignIn?> loginWithFacebook() async {
    try {
      if (kIsWeb) {
        await FacebookAuth.instance.webAndDesktopInitialize(
            appId: '904739884510049',
            cookie: true,
            xfbml: true,
            version: 'v18.0');
      }

      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );
      if (result.status == LoginStatus.success) {
        Map<String, dynamic> mappedJsonResult =
            await FacebookAuth.instance.getUserData();
        FacebookResponse facebookResponse =
            FacebookResponse.fromJson(mappedJsonResult);
        return MyFacebookSignIn(
            loginResult: result, facebookResponse: facebookResponse);
      } else {
        if (kDebugMode) {
          print('login failed: ${result.status.name}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during Facebook sign in: $e");
      }
      return null;
    }
  }

  static Future<void> facebookLogOut() async {
    await FacebookAuth.instance.logOut();
  }
}
