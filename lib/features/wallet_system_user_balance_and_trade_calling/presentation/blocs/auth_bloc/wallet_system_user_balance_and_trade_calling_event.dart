import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/internal_transfer_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_withdrawal_request_request_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/withdraw_entity.dart';

abstract class WalletSystemUserBalanceAndTradeCallingEvent extends Equatable {
  const WalletSystemUserBalanceAndTradeCallingEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllAccountBalanceEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  const FetchAllAccountBalanceEvent();

  @override
  List<Object> get props => [];
}

final class DepositAddressRetrivalEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  final String currency;
  final String chain;
  const DepositAddressRetrivalEvent(
      {required this.currency, required this.chain});

  @override
  List<Object> get props => [
        currency,
        chain,
      ];
}

final class TradeWithdrawalRequestEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  final TradeWithdrawalRequestRequestEntity tradeWithdrawalRequestRequestEntity;

  const TradeWithdrawalRequestEvent({
    required this.tradeWithdrawalRequestRequestEntity,
  });

  @override
  List<Object> get props => [
        tradeWithdrawalRequestRequestEntity,
      ];
}

final class AdminSetWitdrawalEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  final String withdrawalFee;

  const AdminSetWitdrawalEvent({
    required this.withdrawalFee,
  });

  @override
  List<Object> get props => [withdrawalFee];
}

final class GetAdminPendingWithdrawalRequestEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  const GetAdminPendingWithdrawalRequestEvent();

  @override
  List<Object> get props => [];
}

final class InternalTransferEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  final InternalTransferEntity internalTransferEntity;
  const InternalTransferEvent(this.internalTransferEntity);

  @override
  List<Object> get props => [internalTransferEntity];
}

final class FollowTradeCallEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  final String tradeCallID;
  const FollowTradeCallEvent(this.tradeCallID);

  @override
  List<Object> get props => [tradeCallID];
}

final class ListTradesAUserIsFollowingEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  const ListTradesAUserIsFollowingEvent();

  @override
  List<Object> get props => [];
}

final class CreateTradeCallBySuperAdminEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  final TradeEntity tradeEntity;
  const CreateTradeCallBySuperAdminEvent(this.tradeEntity);

  @override
  List<Object> get props => [];
}

final class FetchAllTradesEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  const FetchAllTradesEvent();

  @override
  List<Object> get props => [];
}

final class SetWithdrawalPasswordEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  final String withdrawPasswordConfirmation;
  final String withdrawPassword;
  const SetWithdrawalPasswordEvent(
    this.withdrawPasswordConfirmation,
    this.withdrawPassword,
  );

  @override
  List<Object> get props => [];
}

final class GetpnlEvent extends WalletSystemUserBalanceAndTradeCallingEvent {
  const GetpnlEvent();

  @override
  List<Object> get props => [];
}

///// Withdrawal Event
final class WithdrawalEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  final WithdrawEntity withdrawEntity;

  const WithdrawalEvent({required this.withdrawEntity});

  @override
  List<Object> get props => [withdrawEntity];
}

final class BtcDataChartEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  final String symbol;

  const BtcDataChartEvent({required this.symbol});

  @override
  List<Object> get props => [symbol];
}

// FetchUserTransactions

final class FetchUserTransactionsEvent
    extends WalletSystemUserBalanceAndTradeCallingEvent {
  const FetchUserTransactionsEvent();

  @override
  List<Object> get props => [];
}
