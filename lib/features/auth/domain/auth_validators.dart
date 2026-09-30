abstract final class AuthValidators {
  //TODO: NEED TO REVIEW THIS

  static String? name(String value) {
    if (value.isEmpty) return 'Name required';
    if (value.length < 3) return 'Name is too short';
    return null;
  }

  static String? email(String value) {
    if (value.isEmpty) return 'Email required';
    if (!value.contains('@') || !value.contains('.')) return 'Invalid email';
    return null;
  }

  static String? password(String value) {
    if (value.isEmpty) return 'Password required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}
