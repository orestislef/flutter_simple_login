import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:test_login/models/facebook_response.dart';

class MyFacebookSignIn {
  LoginResult loginResult;
  FacebookResponse facebookResponse;

  MyFacebookSignIn({required this.loginResult, required this.facebookResponse});
}
