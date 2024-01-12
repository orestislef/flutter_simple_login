enum AuthType {
  none,
  google,
  apple,
  facebook,
}

extension AuthTypeExtension on AuthType {
  String get name {
    switch (this) {
      case AuthType.none:
        return "None";
      case AuthType.google:
        return "Google";
      case AuthType.apple:
        return "Apple";
      case AuthType.facebook:
        return "Facebook";
    }
  }
}
