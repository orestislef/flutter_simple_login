enum AuthType {
  google,
  apple,
  facebook,
}

extension AuthTypeExtension on AuthType {
  String get name {
    switch (this) {
      case AuthType.google:
        return "Google";
      case AuthType.apple:
        return "Apple";
      case AuthType.facebook:
        return "Facebook";
    }
  }
}
