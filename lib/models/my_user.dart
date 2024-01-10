import 'package:flutter/foundation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:test_login/models/my_facebook_sign_in.dart';
import 'package:test_login/models/my_google_sign_in.dart';

class MyUser {
  String name;
  String token;

  MyUser({required this.name, required this.token});

  static MyUser createUser(dynamic result) {
    MyUser user = MyUser(name: "No Name", token: "No access token");

    try {
      if (result is MyGoogleSignIn) {
        user.name = result.googleSignInAccount.displayName!;
        user.token = result.googleSignInAuthentication.accessToken!;
      } else if (result is AuthorizationCredentialAppleID) {
        user.name = result.givenName!;
        user.token = result.authorizationCode;
      } else if (result is MyFacebookSignIn) {
        user.name = result.facebookResponse.name!;
        user.token = result.loginResult.accessToken!.token;
      }
    } catch (ignore) {
      if (kDebugMode) {
        print("Error creating user: $ignore");
      }
    }

    return user;
  }
}
