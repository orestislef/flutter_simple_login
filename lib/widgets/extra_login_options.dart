import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:test_login/enums/auth_type.dart';
import 'package:test_login/helpers/login_helper.dart';

class ExtraLoginOptions extends StatelessWidget {
  const ExtraLoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRoundButton(
          color: Colors.blueGrey,
          onPressed: () => _onClickedLogin(
            authType: AuthType.google,
            context: context,
          ),
          child: Image.network(
            'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
            height: 36.0,
            width: 36.0,
          ),
        ),
        const SizedBox(width: 10.0),
        _buildRoundButton(
          color: Colors.green,
          onPressed: () => _onClickedLogin(
            authType: AuthType.apple,
            context: context,
          ),
          child: Image.network(
              'https://cdn3.iconfinder.com/data/icons/picons-social/57/16-apple-256.png',
              height: 36.0),
        ),
        const SizedBox(width: 10.0),
        _buildRoundButton(
          color: Colors.cyan,
          onPressed: () => _onClickedLogin(
            authType: AuthType.facebook,
            context: context,
          ),
          child: Image.network(
              'https://cdn2.iconfinder.com/data/icons/social-media-2285/512/1_Facebook_colored_svg_copy-256.png',
              height: 36.0),
        ),
      ],
    );
  }

  Widget _buildRoundButton(
      {required VoidCallback onPressed,
      required Widget child,
      required MaterialColor color}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15.0),
        backgroundColor: color,
        shadowColor: color.shade100,
        shape: const CircleBorder(),
        elevation: 10.0,
      ),
      child: child,
    );
  }

  void _onClickedLogin(
      {required AuthType authType, required BuildContext context}) {
    switch (authType) {
      case AuthType.google:
        LoginHelper.loginWithGoogle()
            .then((myGoogleSignIn) => myGoogleSignIn != null
                ? _onSuccessGoogleLogin(
                    myGoogleSignIn: myGoogleSignIn,
                    context: context,
                  )
                : _onErrorLogin(
                    authType: authType,
                    context: context,
                  ));
        break;
      case AuthType.apple:
        LoginHelper.loginWithApple().then((authorizationCredentialAppleID) =>
            authorizationCredentialAppleID != null
                ? _onSuccessAppleLogin(
                    authorizationCredentialAppleID:
                        authorizationCredentialAppleID,
                    context: context)
                : _onErrorLogin(
                    authType: authType,
                    context: context,
                  ));
        break;
      case AuthType.facebook:
        LoginHelper.loginWithFacebook().then((loginResult) =>
            loginResult != null
                ? _onSuccessFacebookLogin(
                    loginResult: loginResult, context: context)
                : _onErrorLogin(authType: authType, context: context));
        break;
    }
  }

  void _onSuccessGoogleLogin(
      {required MyGoogleSignIn myGoogleSignIn, required BuildContext context}) {
    String displayName =
        myGoogleSignIn.googleSignInAccount.displayName ?? "No Name";

    if (kDebugMode) {
      print("User $displayName logged in successfully");
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logged in successfully $displayName'),
        content: Text(myGoogleSignIn.googleSignInAuthentication.accessToken ??
            "no access token"),
      ),
    );
  }

  void _onSuccessAppleLogin(
      {required AuthorizationCredentialAppleID authorizationCredentialAppleID,
      required BuildContext context}) {
    String displayName = authorizationCredentialAppleID.givenName ?? "No Name";

    if (kDebugMode) {
      print("User $displayName logged in successfully");
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Logged in successfully $displayName'),
              content: Text(authorizationCredentialAppleID.authorizationCode),
            ));
  }

  void _onSuccessFacebookLogin(
      {required LoginResult loginResult, required BuildContext context}) {
    if (kDebugMode) {
      print("User logged in successfully");
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Logged in successfully'),
              content: Text(loginResult.accessToken!.token),
            ));
  }

  void _onErrorLogin(
      {required AuthType authType, required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text('Error with login with ${authType.name}')));
  }
}
