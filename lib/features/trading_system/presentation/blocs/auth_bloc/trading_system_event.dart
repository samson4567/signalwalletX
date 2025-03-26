import 'package:equatable/equatable.dart';

abstract class TradingSystemEvent extends Equatable {
  const TradingSystemEvent();

  @override
  List<Object> get props => [];
}

final class NewUserSignUpEvent extends TradingSystemEvent {
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

final class VerifyNewSignUpEmailEvent extends TradingSystemEvent {
  final String email;
  final String otp;

  const VerifyNewSignUpEmailEvent({
    required this.email,
    required this.otp,
  });

  @override
  List<Object> get props => [email, otp];
}

final class ResendOtpEvent extends TradingSystemEvent {
  final String email;

  const ResendOtpEvent({required this.email});

  @override
  List<Object> get props => [email];
}

final class LoginEvent extends TradingSystemEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

final class LogoutEvent extends TradingSystemEvent {
  final String token;

  const LogoutEvent({required this.token});

  @override
  List<Object> get props => [token];
}

final class UpdatePasswordEvent extends TradingSystemEvent {
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

// FetchLiveMarketPrices
final class FetchLiveMarketPricesEvent extends TradingSystemEvent {
  const FetchLiveMarketPricesEvent();

  @override
  List<Object> get props => [];
}
