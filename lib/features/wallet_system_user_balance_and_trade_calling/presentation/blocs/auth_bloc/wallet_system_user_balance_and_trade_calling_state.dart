import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/admin_pending_withdrawal_request_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/trade_withdrawal_request_response_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/btc_chart_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/deposit_address_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/withdraw_entity.dart';

sealed class WalletSystemUserBalanceAndTradeCallingState extends Equatable {
  const WalletSystemUserBalanceAndTradeCallingState();

  @override
  List<Object> get props => [];
}

final class WalletSystemUserBalanceAndTradeCallingInitial
    extends WalletSystemUserBalanceAndTradeCallingState {
  const WalletSystemUserBalanceAndTradeCallingInitial();
}

///// FetchAllAccountBalance
final class FetchAllAccountBalanceLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const FetchAllAccountBalanceLoadingState();
}

final class FetchAllAccountBalanceSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final List<WalletAccountEntity> listOfWalletsBalances;

  const FetchAllAccountBalanceSuccessState(
      {required this.listOfWalletsBalances});

  @override
  List<Object> get props => [listOfWalletsBalances];
}

final class FetchAllAccountBalanceErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const FetchAllAccountBalanceErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class DepositAddressRetrivalLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const DepositAddressRetrivalLoadingState();
}

final class DepositAddressRetrivalSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final DepositAddressEntity depositAddressEntity;

  const DepositAddressRetrivalSuccessState(
      {required this.depositAddressEntity});

  @override
  List<Object> get props => [depositAddressEntity];
}

final class DepositAddressRetrivalErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const DepositAddressRetrivalErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// DepositAddressRetrival ended .....

///// TradeWithdrawalRequest
final class TradeWithdrawalRequestLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const TradeWithdrawalRequestLoadingState();
}

final class TradeWithdrawalRequestSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final TradeWithdrawalRequestResponseModel tradeWithdrawalRequestResponseModel;

  const TradeWithdrawalRequestSuccessState(
      {required this.tradeWithdrawalRequestResponseModel});

  @override
  List<Object> get props => [tradeWithdrawalRequestResponseModel];
}

final class TradeWithdrawalRequestErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const TradeWithdrawalRequestErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// TradeWithdrawalRequest ended .....

///// GetAdminPendingWithdrawalRequest
final class AdminSetWitdrawalLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const AdminSetWitdrawalLoadingState();
}

final class AdminSetWitdrawalSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String message;

  const AdminSetWitdrawalSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class AdminSetWitdrawalErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const AdminSetWitdrawalErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// AdminSetWitdrawal ended .....

// GetAdminPendingWithdrawalRequest
///// GetAdminPendingWithdrawalRequest
final class GetAdminPendingWithdrawalRequestLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const GetAdminPendingWithdrawalRequestLoadingState();
}

final class GetAdminPendingWithdrawalRequestSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final List<AdminPendingWithdrawalRequestModel>
      listOfAdminPendingWithdrawalRequest;

  const GetAdminPendingWithdrawalRequestSuccessState(
      {required this.listOfAdminPendingWithdrawalRequest});

  @override
  List<Object> get props => [listOfAdminPendingWithdrawalRequest];
}

final class GetAdminPendingWithdrawalRequestErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const GetAdminPendingWithdrawalRequestErrorState(
      {required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// GetAdminPendingWithdrawalRequest ended .....

///// InternalTransfer
final class InternalTransferLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const InternalTransferLoadingState();
}

final class InternalTransferSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String message;

  const InternalTransferSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class InternalTransferErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const InternalTransferErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// InternalTransfer ended .....

///// FollowTradeCall
final class FollowTradeCallLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const FollowTradeCallLoadingState();
}

final class FollowTradeCallSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String message;

  const FollowTradeCallSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class FollowTradeCallErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const FollowTradeCallErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// FollowTradeCall ended .....

///// ListTradesAUserIsFollowing
final class ListTradesAUserIsFollowingLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const ListTradesAUserIsFollowingLoadingState();
}

final class ListTradesAUserIsFollowingSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final List<TradeEntity> listOfTradeEntities;

  const ListTradesAUserIsFollowingSuccessState(
      {required this.listOfTradeEntities});

  @override
  List<Object> get props => [listOfTradeEntities];
}

final class ListTradesAUserIsFollowingErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const ListTradesAUserIsFollowingErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// ListTradesAUserIsFollowing ended .....

///// CreateTradeCallBySuperAdmin
final class CreateTradeCallBySuperAdminLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const CreateTradeCallBySuperAdminLoadingState();
}

final class CreateTradeCallBySuperAdminSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final TradeEntity tradeEntity;

  const CreateTradeCallBySuperAdminSuccessState({required this.tradeEntity});

  @override
  List<Object> get props => [tradeEntity];
}

final class CreateTradeCallBySuperAdminErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const CreateTradeCallBySuperAdminErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// CreateTradeCallBySuperAdmin ended .....

///// FetchAllTrades
final class FetchAllTradesLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const FetchAllTradesLoadingState();
}

final class FetchAllTradesSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final List<TradeEntity> listOfTradeEntities;

  const FetchAllTradesSuccessState({required this.listOfTradeEntities});

  @override
  List<Object> get props => [listOfTradeEntities];
}

final class FetchAllTradesErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const FetchAllTradesErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// FetchAllTrades ended .....

///// SetWithdrawalPassword
final class SetWithdrawalPasswordLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const SetWithdrawalPasswordLoadingState();
}

final class SetWithdrawalPasswordSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String message;

  const SetWithdrawalPasswordSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class SetWithdrawalPasswordErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const SetWithdrawalPasswordErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// SetWithdrawalPassword ended .....

///// Getpnl
final class GetpnlLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const GetpnlLoadingState();
}

final class GetpnlSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String pnl;

  const GetpnlSuccessState({required this.pnl});

  @override
  List<Object> get props => [pnl];
}

final class GetpnlErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const GetpnlErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// Getpnl ended .....

// Getpnl

final class WithdrawalLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const WithdrawalLoadingState();
}

final class WithdrawalSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final WithdrawEntity withdrawEntity;

  const WithdrawalSuccessState(
      {required this.withdrawEntity, required message});

  @override
  List<Object> get props => [withdrawEntity];
}

final class WithdrawalErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const WithdrawalErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// BtcDataChart
final class BtcDataChartLoadingState
    extends WalletSystemUserBalanceAndTradeCallingState {
  const BtcDataChartLoadingState();
}

class BtcDataChartSuccessState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final BtcDataChartEntity btcDataChart;

  const BtcDataChartSuccessState({required this.btcDataChart});
}

final class BtcDataChartErrorState
    extends WalletSystemUserBalanceAndTradeCallingState {
  final String errorMessage;

  const BtcDataChartErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
