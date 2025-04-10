import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/authentication/domain/entities/language_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/recent_transaction_entity.dart';

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

// Reset Password States
final class ResetPasswordLoadingState extends AuthState {
  const ResetPasswordLoadingState();
}

final class ResetPasswordSuccessState extends AuthState {
  final String message;

  const ResetPasswordSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class ResetPasswordErrorState extends AuthState {
  final String errorMessage;

  const ResetPasswordErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// ✅ Added Update Password States
final class UpdatePasswordLoadingState extends AuthState {
  const UpdatePasswordLoadingState();
}

final class UpdatePasswordSuccessState extends AuthState {
  final String message;

  const UpdatePasswordSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdatePasswordErrorState extends AuthState {
  final String errorMessage;

  const UpdatePasswordErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class GoogleAuthLoadingState extends AuthState {
  const GoogleAuthLoadingState();
}

class GoogleAuthSuccessState extends AuthState {
  final String message;

  const GoogleAuthSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class GoogleAuthErrorState extends AuthState {
  final String errorMessage;

  const GoogleAuthErrorState(String message, {required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// ✅ Forget Password States
final class ForgetPasswordLoadingState extends AuthState {
  const ForgetPasswordLoadingState();
}

final class ForgetPasswordSuccessState extends AuthState {
  final String message;

  const ForgetPasswordSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class ForgetPasswordErrorState extends AuthState {
  final String errorMessage;

  const ForgetPasswordErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class RecentTransactionLoadingState extends AuthState {
  const RecentTransactionLoadingState();

  @override
  List<Object> get props => []; // Add empty props array
}

final class RecentTransactionSuccessState extends AuthState {
  final List<RecentTransactionEntity> transactions;

  const RecentTransactionSuccessState({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

final class RecentTransactionErrorState extends AuthState {
  final String errorMessage;

  const RecentTransactionErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// OTP Loading State
class OtpVerificationLoadingState extends AuthState {
  const OtpVerificationLoadingState();
}

// OTP Success State
class OtpVerificationSuccessState extends AuthState {
  final String message;

  const OtpVerificationSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

// OTP Error State
class OtpVerificationErrorState extends AuthState {
  final String errorMessage;

  const OtpVerificationErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

sealed class SetNewPasswordState extends Equatable {
  const SetNewPasswordState();

  @override
  List<Object> get props => [];
}

class SetNewPasswordLoadingState extends AuthState {
  const SetNewPasswordLoadingState();
}

class SetNewPasswordSuccessState extends AuthState {
  final String message;

  const SetNewPasswordSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class SetNewPasswordErrorState extends AuthState {
  final String errorMessage;

  const SetNewPasswordErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// Language States
final class FetchLanguagesLoadingState extends AuthState {
  const FetchLanguagesLoadingState();
}

final class FetchLanguagesSuccessState extends AuthState {
  final List<LanguagesEntity> languages;

  const FetchLanguagesSuccessState({required this.languages});

  @override
  List<Object> get props => [languages];
}

final class FetchLanguagesErrorState extends AuthState {
  final String errorMessage;

  const FetchLanguagesErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
