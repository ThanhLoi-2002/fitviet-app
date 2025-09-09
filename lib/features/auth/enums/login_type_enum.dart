enum LoginType {
  google, facebook
}

extension LoginTypeExtension on LoginType {
  String get value {
    switch (this) {
      case LoginType.google:
        return 'google';
      case LoginType.facebook:
        return 'facebook';
    }
  }
}
