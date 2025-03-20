import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

// Sign Up States
final class NewUserSignUpLoadingState extends AuthState {
  const NewUserSignUpLoadingState();
}

final class NewUserSignUpSuccessState extends AuthState {
  final String message;

  const NewUserSignUpSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class NewUserSignUpErrorState extends AuthState {
  final String errorMessage;

  const NewUserSignUpErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// Verify Sign Up States
final class VerifyNewSignUpEmailLoadingState extends AuthState {
  const VerifyNewSignUpEmailLoadingState();
}

final class VerifyNewSignUpEmailSuccessState extends AuthState {
  final String message;

  const VerifyNewSignUpEmailSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class VerifyNewSignUpEmailErrorState extends AuthState {
  final String errorMessage;

  const VerifyNewSignUpEmailErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// Resend OTP States
final class ResendOtpLoadingState extends AuthState {
  const ResendOtpLoadingState();
}

final class ResendOtpSuccessState extends AuthState {
  final String message;

  const ResendOtpSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class ResendOtpErrorState extends AuthState {
  final String errorMessage;

  const ResendOtpErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// Login States
final class LoginLoadingState extends AuthState {
  const LoginLoadingState();
}

final class LoginSuccessState extends AuthState {
  final String email;
  final String message;

  const LoginSuccessState({required this.email, required this.message});

  @override
  List<Object> get props => [email, message];
}

final class LoginErrorState extends AuthState {
  final String errorMessage;

  const LoginErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// Logout States
final class LogoutLoadingState extends AuthState {
  const LogoutLoadingState();
}

final class LogoutSuccessState extends AuthState {
  final String message;

  const LogoutSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class LogoutErrorState extends AuthState {
  final String errorMessage;

  const LogoutErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
