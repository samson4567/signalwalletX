import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_bloc.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_event.dart';

getAndSetInitialData(BuildContext context) {
  context
      .read<WalletSystemUserBalanceAndTradeCallingBloc>()
      .add(const GetpnlEvent());
  getUserCoinBalances(context);
  getCoins(context);
}

getUserCoinBalances(BuildContext context) {
  context
      .read<WalletSystemUserBalanceAndTradeCallingBloc>()
      .add(FetchAllAccountBalanceEvent());
}

getCoins(BuildContext context) {
  context.read<TradingSystemBloc>().add(GetCoinListEvent());
}

WalletAccountEntity? getCoinWaletDetails(
    BuildContext context, CoinEntity coinEntity) {
  // coinEntity.chains.;
  WalletAccountEntity? result;
  List<WalletAccountEntity> walletAccountEntities =
      context.read<AppBloc>().state.listOfWalletAccounts ?? [];
  walletAccountEntities.forEach((element) {
    if (element.currency == coinEntity.symbol) result = element;
  });
  return result;
}

Uint8List getImageDataFromString(String base64Image) {
  String base64String = base64Image.split(',').last;
  Uint8List bytes = base64.decode(base64String);
  return bytes;
}
