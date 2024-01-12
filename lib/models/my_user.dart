import 'package:flutter/foundation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:test_login/enums/auth_type.dart';
import 'package:test_login/models/my_facebook_sign_in.dart';
import 'package:test_login/models/my_google_sign_in.dart';

const defaultUserImageUrl =
    'https://static.thenounproject.com/png/854888-200.png';

class MyUser {
  String name;
  String token;
  String imageUrl;
  AuthType authType;

  MyUser(
      {required this.name,
      required this.token,
      required this.imageUrl,
      required this.authType});

  static MyUser createUser(dynamic result) {
    MyUser user = MyUser(
        name: "No Name",
        token: "No access token",
        imageUrl: defaultUserImageUrl,
        authType: AuthType.none);

    try {
      if (result is MyGoogleSignIn) {
        user.name = result.googleSignInAccount.displayName!;
        user.token = result.googleSignInAuthentication.accessToken!;
        user.authType = AuthType.google;
        user.imageUrl =
            result.googleSignInAccount.photoUrl ?? defaultUserImageUrl;
      } else if (result is AuthorizationCredentialAppleID) {
        user.name = result.givenName!;
        user.token = result.authorizationCode;
        user.authType = AuthType.apple;
        user.imageUrl = defaultUserImageUrl;
      } else if (result is MyFacebookSignIn) {
        user.name = result.facebookResponse.name!;
        user.token = result.loginResult.accessToken!.token;
        user.authType = AuthType.facebook;
        user.imageUrl =
            result.facebookResponse.picture?.data?.url ?? defaultUserImageUrl;
      }
    } catch (ignore) {
      if (kDebugMode) {
        print("Error creating user: $ignore");
      }
    }

    return user;
  }
}
