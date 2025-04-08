import 'package:equatable/equatable.dart';

class SetNewPasswordEntity extends Equatable {
  final String email;
  final String password;
  final String passwordConfirmation;

  const SetNewPasswordEntity({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object?> get props => [email, password, passwordConfirmation];
}
