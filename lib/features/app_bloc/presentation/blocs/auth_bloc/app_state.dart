import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';

import 'package:signalwavex/features/user/data/models/user_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/wallet_account_balance_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';

// ignore: must_be_immutable
class AppState extends Equatable {
  AppState(
      {this.user, this.pnl, this.listOfWalletAccounts, this.listOfCoinEntity});
  UserModel? user = UserModel.empty();
  String? pnl;
  List<WalletAccountEntity>? listOfWalletAccounts;
  List<CoinEntity>? listOfCoinEntity;

  @override
  List<Object> get props => [];
  AppState copyWith({
    UserModel? user,
    String? pnl,
    List<WalletAccountEntity>? listOfWalletAccounts,
    List<CoinEntity>? listOfCoinEntity,
  }) {
    return AppState(
      listOfCoinEntity: listOfCoinEntity ?? this.listOfCoinEntity,
      listOfWalletAccounts: listOfWalletAccounts ?? this.listOfWalletAccounts,
      pnl: pnl ?? this.pnl,
      user: user ?? this.user,
    );
  }

  Map toMap() {
    return {
      "user": user,
      "pnl": pnl,
      "listOfWalletAccounts": listOfWalletAccounts
          ?.map(
            (e) => WalletAccountModel.fromEntity(e).toJson(),
          )
          .toList(),
      "listOfCoinEntity": listOfCoinEntity
          ?.map(
            (e) => CoinModel.fromEntity(e).toJson(),
          )
          .toList()
      // listOfCoinEntity,
    };
  }

  AppState fromMap(Map json) {
    return AppState(
      listOfCoinEntity: [
        ...(json["listOfCoinEntity"] as List<Map>?)?.map(
              (e) => CoinModel.fromJson(e),
            ) ??
            []
      ],
      listOfWalletAccounts: [
        ...(json["listOfWalletAccounts"] as List<Map>?)?.map(
              (e) => WalletAccountModel.fromJson(e),
            ) ??
            []
      ],
      pnl: json["pnl"],
      user: json["user"],
    );
  }
}

// ignore: must_be_immutable
final class AppInitial extends AppState {
  AppInitial();
}

// user update States
// ignore: must_be_immutable
final class UserUpdateLoadingState extends AppState {
  UserUpdateLoadingState({
    required super.user,
    super.listOfCoinEntity,
    super.listOfWalletAccounts,
    super.pnl,
  });
  factory UserUpdateLoadingState.fromAppState(AppState appState) {
    return UserUpdateLoadingState(
      user: appState.user,
      listOfCoinEntity: appState.listOfCoinEntity,
      listOfWalletAccounts: appState.listOfWalletAccounts,
      pnl: appState.pnl,
    );
  }
}

// ignore: must_be_immutable
final class UserUpdateSuccessState extends AppState {
  @override
  UserUpdateSuccessState({
    required super.user,
    super.listOfCoinEntity,
    super.listOfWalletAccounts,
    super.pnl,
  });

  @override
  List<Object> get props => [user!];
  factory UserUpdateSuccessState.fromAppState(AppState appState) {
    return UserUpdateSuccessState(
      user: appState.user,
      listOfCoinEntity: appState.listOfCoinEntity,
      listOfWalletAccounts: appState.listOfWalletAccounts,
      pnl: appState.pnl,
    );
  }
}

// ignore: must_be_immutable
final class UserUpdateErrorState extends AppState {
  final String errorMessage;

  UserUpdateErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// StorePNL
// ignore: must_be_immutable
final class StorePNLLoadingState extends AppState {
  StorePNLLoadingState({
    super.user,
    super.listOfCoinEntity,
    super.listOfWalletAccounts,
    super.pnl,
  });
  factory StorePNLLoadingState.fromAppState(AppState appState) {
    return StorePNLLoadingState(
      user: appState.user,
      listOfCoinEntity: appState.listOfCoinEntity,
      listOfWalletAccounts: appState.listOfWalletAccounts,
      pnl: appState.pnl,
    );
  }
}

// ignore: must_be_immutable
final class StorePNLSuccessState extends AppState {
  @override
  // ignore: overridden_fields
  // String ? user = UserModel.empty();
  StorePNLSuccessState({
    super.user,
    super.listOfCoinEntity,
    super.listOfWalletAccounts,
    super.pnl,
  });

  @override
  List<Object> get props => [user!];
  factory StorePNLSuccessState.fromAppState(AppState appState) {
    return StorePNLSuccessState(
      user: appState.user,
      listOfCoinEntity: appState.listOfCoinEntity,
      listOfWalletAccounts: appState.listOfWalletAccounts,
      pnl: appState.pnl,
    );
  }
}

// ignore: must_be_immutable
final class StorePNLErrorState extends AppState {
  final String errorMessage;

  StorePNLErrorState({
    required this.errorMessage,
    super.user,
    super.listOfCoinEntity,
    super.listOfWalletAccounts,
    super.pnl,
  });

  @override
  List<Object> get props => [errorMessage];
  factory StorePNLErrorState.fromAppState(
      AppState appState, String errorMessage) {
    return StorePNLErrorState(
      errorMessage: errorMessage,
      user: appState.user,
      listOfCoinEntity: appState.listOfCoinEntity,
      listOfWalletAccounts: appState.listOfWalletAccounts,
      pnl: appState.pnl,
    );
  }
}

// StoreUserBalances
// ignore: must_be_immutable
final class StoreUserBalancesLoadingState extends AppState {
  StoreUserBalancesLoadingState({
    super.user,
    super.listOfCoinEntity,
    super.listOfWalletAccounts,
    super.pnl,
  });
  factory StoreUserBalancesLoadingState.fromAppState(AppState appState) {
    return StoreUserBalancesLoadingState(
      user: appState.user,
      listOfCoinEntity: appState.listOfCoinEntity,
      listOfWalletAccounts: appState.listOfWalletAccounts,
      pnl: appState.pnl,
    );
  }
}

// ignore: must_be_immutable
final class StoreUserBalancesSuccessState extends AppState {
  @override
  StoreUserBalancesSuccessState({
    super.user,
    super.listOfCoinEntity,
    super.listOfWalletAccounts,
    super.pnl,
  });

  @override
  List<Object> get props => [user!];
  factory StoreUserBalancesSuccessState.fromAppState(AppState appState) {
    return StoreUserBalancesSuccessState(
      user: appState.user,
      listOfCoinEntity: appState.listOfCoinEntity,
      listOfWalletAccounts: appState.listOfWalletAccounts,
      pnl: appState.pnl,
    );
  }
}

// ignore: must_be_immutable
final class StoreUserBalancesErrorState extends AppState {
  final String errorMessage;

  StoreUserBalancesErrorState({
    required this.errorMessage,
    super.user,
    super.listOfCoinEntity,
    super.listOfWalletAccounts,
    super.pnl,
  });

  @override
  List<Object> get props => [errorMessage];
  factory StoreUserBalancesErrorState.fromAppState(
      AppState appState, String errorMessage) {
    return StoreUserBalancesErrorState(
      errorMessage: errorMessage,
      user: appState.user,
      listOfCoinEntity: appState.listOfCoinEntity,
      listOfWalletAccounts: appState.listOfWalletAccounts,
      pnl: appState.pnl,
    );
  }
}

// StoreUserBalances ended ....

// StoreCoins
// ignore: must_be_immutable
final class StoreCoinsLoadingState extends AppState {
  StoreCoinsLoadingState({
    super.user,
    super.listOfCoinEntity,
    super.listOfWalletAccounts,
    super.pnl,
  });
  factory StoreCoinsLoadingState.fromAppState(AppState appState) {
    return StoreCoinsLoadingState(
      user: appState.user,
      listOfCoinEntity: appState.listOfCoinEntity,
      listOfWalletAccounts: appState.listOfWalletAccounts,
      pnl: appState.pnl,
    );
  }
}

// ignore: must_be_immutable
final class StoreCoinsSuccessState extends AppState {
  @override
  StoreCoinsSuccessState({
    super.user,
    super.listOfCoinEntity,
    super.listOfWalletAccounts,
    super.pnl,
  });

  @override
  List<Object> get props => [user!];
  factory StoreCoinsSuccessState.fromAppState(AppState appState) {
    return StoreCoinsSuccessState(
      user: appState.user,
      listOfCoinEntity: appState.listOfCoinEntity,
      listOfWalletAccounts: appState.listOfWalletAccounts,
      pnl: appState.pnl,
    );
  }
}

// ignore: must_be_immutable
final class StoreCoinsErrorState extends AppState {
  final String errorMessage;

  StoreCoinsErrorState({
    required this.errorMessage,
    super.user,
    super.listOfCoinEntity,
    super.listOfWalletAccounts,
    super.pnl,
  });

  @override
  List<Object> get props => [errorMessage];
  factory StoreCoinsErrorState.fromAppState(
      AppState appState, String errorMessage) {
    return StoreCoinsErrorState(
      errorMessage: errorMessage,
      user: appState.user,
      listOfCoinEntity: appState.listOfCoinEntity,
      listOfWalletAccounts: appState.listOfWalletAccounts,
      pnl: appState.pnl,
    );
  }
}

// StoreCoins ended ....



// StoreCoins