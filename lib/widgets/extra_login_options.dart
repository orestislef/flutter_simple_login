import 'package:universal_io/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:test_login/enums/auth_type.dart';
import 'package:test_login/helpers/login_helper.dart';
import 'package:test_login/models/my_user.dart';

class ExtraLoginOptions extends StatelessWidget {
  const ExtraLoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(AuthType.google, context),
        Platform.isIOS ? const SizedBox(width: 10.0) : const SizedBox(),
        Platform.isIOS
            ? _buildSocialButton(AuthType.apple, context)
            : const SizedBox(),
        const SizedBox(width: 10.0),
        _buildSocialButton(AuthType.facebook, context),
      ],
    );
  }

  Widget _buildSocialButton(AuthType authType, BuildContext context) {
    return FlutterSocialButton(
      onTap: () => _onClickedLogin(authType: authType, context: context),
      mini: true,
      buttonType: getButtonType(authType),
    );
  }

  ButtonType getButtonType(AuthType authType) {
    switch (authType) {
      case AuthType.google:
        return ButtonType.google;
      case AuthType.apple:
        return ButtonType.apple;
      case AuthType.facebook:
        return ButtonType.facebook;
    }
  }

  void _onClickedLogin(
      {required AuthType authType, required BuildContext context}) {
    LoginHelper.loginWithAuthType(authType).then(
      (result) => result != null
          ? _onSuccessLogin(result, context)
          : _onErrorLogin(authType, context),
    );
  }

  void _onSuccessLogin(dynamic result, BuildContext context) {
    MyUser user = MyUser.createUser(result);

    String displayName = user.name;
    String accessToken = user.token;

    if (kDebugMode) {
      print("User $displayName logged in successfully");
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logged in successfully $displayName'),
        content: SelectableText(accessToken),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _onErrorLogin(AuthType authType, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error with login with ${authType.name}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
