import 'package:google_sign_in/google_sign_in.dart';

class MyGoogleSignIn {
  final GoogleSignInAccount googleSignInAccount;
  final GoogleSignInAuthentication googleSignInAuthentication;

  MyGoogleSignIn({
    required this.googleSignInAccount,
    required this.googleSignInAuthentication,
  });
}