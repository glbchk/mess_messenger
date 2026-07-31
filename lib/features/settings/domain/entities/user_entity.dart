class UserEntity {
  final bool? isAnonymous;
  final String id;
  final String? name;
  final String? email;
  final bool? isEmailVerified;
  final String? phoneNumber;
  final String? birthday;
  final bool isOnboardingCompleted;
  final String? language;

  UserEntity({
    this.isAnonymous,
    required this.id,
    this.name,
    this.email,
    this.isEmailVerified,
    this.phoneNumber,
    this.birthday,
    required this.isOnboardingCompleted,
    this.language,
  });
}
