import '../../domain/entities/set_entity.dart';

class SetNewPassword extends SetNewPasswordEntity {
  const SetNewPassword({
    required super.email,
    required super.password,
    required super.passwordConfirmation,
  });

  // From JSON
  factory SetNewPassword.fromJson(Map<String, dynamic> json) {
    return SetNewPassword(
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
