import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class NewUserSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const NewUserSignUpEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [email, password, confirmPassword];
}

final class VerifyNewSignUpEmailEvent extends AuthEvent {
  final String email;
  final String otp;

  const VerifyNewSignUpEmailEvent({
    required this.email,
    required this.otp,
  });

  @override
  List<Object> get props => [email, otp];
}

final class ResendOtpEvent extends AuthEvent {
  final String email;

  const ResendOtpEvent({required this.email});

  @override
  List<Object> get props => [email];
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

final class LogoutEvent extends AuthEvent {
  final String token;

  const LogoutEvent({required this.token});

  @override
  List<Object> get props => [token];
}
