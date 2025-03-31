import 'package:equatable/equatable.dart';

import 'package:signalwavex/features/user/data/models/user_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';

// ignore: must_be_immutable
sealed class AppState extends Equatable {
  AppState({this.user, this.pnl, this.listOfWalletAccounts});
  UserModel? user = UserModel.empty();
  String? pnl;
  List<WalletAccountEntity>? listOfWalletAccounts;

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
final class AppInitial extends AppState {
  AppInitial();
}

// user update States
// ignore: must_be_immutable
final class UserUpdateLoadingState extends AppState {
  UserUpdateLoadingState();
}

// ignore: must_be_immutable
final class UserUpdateSuccessState extends AppState {
  @override
  // ignore: overridden_fields
  UserModel? user = UserModel.empty();
  UserUpdateSuccessState({required this.user}) {}

  @override
  List<Object> get props => [user!];
}

// ignore: must_be_immutable
final class UserUpdateErrorState extends AppState {
  final String errorMessage;

  UserUpdateErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// StorePNL
final class StorePNLLoadingState extends AppState {
  StorePNLLoadingState();
}

// ignore: must_be_immutable
final class StorePNLSuccessState extends AppState {
  @override
  // ignore: overridden_fields
  // String ? user = UserModel.empty();
  StorePNLSuccessState({super.pnl});

  @override
  List<Object> get props => [user!];
}

// ignore: must_be_immutable
final class StorePNLErrorState extends AppState {
  final String errorMessage;

  StorePNLErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// StoreUserBalances
final class StoreUserBalancesLoadingState extends AppState {
  StoreUserBalancesLoadingState();
}

// ignore: must_be_immutable
final class StoreUserBalancesSuccessState extends AppState {
  @override
  StoreUserBalancesSuccessState({super.listOfWalletAccounts});

  @override
  List<Object> get props => [user!];
}

// ignore: must_be_immutable
final class StoreUserBalancesErrorState extends AppState {
  final String errorMessage;

  StoreUserBalancesErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// StoreUserBalances ended ....
