import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/trading_system/domain/entities/live_market_price_entity.dart';

sealed class TradingSystemState extends Equatable {
  const TradingSystemState();

  @override
  List<Object> get props => [];
}

final class TradingSystemInitial extends TradingSystemState {
  const TradingSystemInitial();
}

///// FetchLiveMarketPrices
final class FetchLiveMarketPricesLoadingState extends TradingSystemState {
  const FetchLiveMarketPricesLoadingState();
}

final class FetchLiveMarketPricesSuccessState extends TradingSystemState {
  final List<LiveMarketPriceEntity> listOfLiveMarketPriceEntity;

  const FetchLiveMarketPricesSuccessState(
      {required this.listOfLiveMarketPriceEntity});

  @override
  List<Object> get props => [listOfLiveMarketPriceEntity];
}

final class FetchLiveMarketPricesErrorState extends TradingSystemState {
  final String errorMessage;

  const FetchLiveMarketPricesErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// FetchLiveMarketPrices ended .....

///// old states

// Sign Up States
final class NewUserSignUpLoadingState extends TradingSystemState {
  const NewUserSignUpLoadingState();
}

final class NewUserSignUpSuccessState extends TradingSystemState {
  final String message;

  const NewUserSignUpSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class NewUserSignUpErrorState extends TradingSystemState {
  final String errorMessage;

  const NewUserSignUpErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// Verify Sign Up States
final class VerifyNewSignUpEmailLoadingState extends TradingSystemState {
  const VerifyNewSignUpEmailLoadingState();
}

final class VerifyNewSignUpEmailSuccessState extends TradingSystemState {
  final String message;

  const VerifyNewSignUpEmailSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class VerifyNewSignUpEmailErrorState extends TradingSystemState {
  final String errorMessage;

  const VerifyNewSignUpEmailErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// Resend OTP States
final class ResendOtpLoadingState extends TradingSystemState {
  const ResendOtpLoadingState();
}

final class ResendOtpSuccessState extends TradingSystemState {
  final String message;

  const ResendOtpSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class ResendOtpErrorState extends TradingSystemState {
  final String errorMessage;

  const ResendOtpErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// Login States
final class LoginLoadingState extends TradingSystemState {
  const LoginLoadingState();
}

final class LoginSuccessState extends TradingSystemState {
  final String email;
  final String message;

  const LoginSuccessState({required this.email, required this.message});

  @override
  List<Object> get props => [email, message];
}

final class LoginErrorState extends TradingSystemState {
  final String errorMessage;

  const LoginErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// Logout States
final class LogoutLoadingState extends TradingSystemState {
  const LogoutLoadingState();
}

final class LogoutSuccessState extends TradingSystemState {
  final String message;

  const LogoutSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class LogoutErrorState extends TradingSystemState {
  final String errorMessage;

  const LogoutErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// Reset Password States
final class ResetPasswordLoadingState extends TradingSystemState {
  const ResetPasswordLoadingState();
}

final class ResetPasswordSuccessState extends TradingSystemState {
  final String message;

  const ResetPasswordSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class ResetPasswordErrorState extends TradingSystemState {
  final String errorMessage;

  const ResetPasswordErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// ✅ Added Update Password States
final class UpdatePasswordLoadingState extends TradingSystemState {
  const UpdatePasswordLoadingState();
}

final class UpdatePasswordSuccessState extends TradingSystemState {
  final String message;

  const UpdatePasswordSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdatePasswordErrorState extends TradingSystemState {
  final String errorMessage;

  const UpdatePasswordErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
