import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signalwavex/features/authentication/data/models/set_new_password.dart';

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

final class UpdatePasswordEvent extends AuthEvent {
  final String currentPassword;
  final String newPassword;
  final String newPasswordConfirmation;

  const UpdatePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  @override
  List<Object> get props =>
      [currentPassword, newPassword, newPasswordConfirmation];
}

class GoogleAuthEvent extends AuthEvent {
  final GoogleSignInAccount googleUser;

  const GoogleAuthEvent(
      {required this.googleUser,
      required String token,
      required String googleToken});
}

// ✅ Forget Password Event
final class ForgetPasswordEvent extends AuthEvent {
  final String email;

  const ForgetPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

/// Event to fetch recent transactions for a specific user
final class FetchRecentTransactions extends AuthEvent {
  final String userId;

  const FetchRecentTransactions({required this.userId});

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'FetchRecentTransactions(userId: $userId)';
}

class OtpVerificationEvent extends AuthEvent {
  final String otp;

  const OtpVerificationEvent({required this.otp});

  @override
  List<Object> get props => [otp];
}

class SetNewPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const SetNewPasswordEvent(
    this.email,
    this.password,
    this.confirmPassword,
  );

  @override
  List<Object> get props => [email, password, confirmPassword];
}
