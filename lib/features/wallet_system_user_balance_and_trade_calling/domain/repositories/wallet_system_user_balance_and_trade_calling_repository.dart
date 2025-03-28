import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/admin_pending_withdrawal_request_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/deposit_address_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/internal_transfer_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_withdrawal_request_request_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_withdrawal_request_response_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';

abstract class WalletSystemUserBalanceAndTradeCallingRepository {
  Future<Either<Failure, List<WalletAccountEntity>>> fetchAllBalances();
  Future<Either<Failure, DepositAddressEntity>> retriveDepositAddress(
      {required String chain, required String currency});

  Future<Either<Failure, TradeWithdrawalRequestResponseEntity>>
      requestTradeWithdrawal(
          {required TradeWithdrawalRequestRequestEntity
              tradeWithdrawalRequestRequestEntity});
  Future<Either<Failure, String>> adminSetWitdrawal(
      {required String withdrawalFee});

  Future<Either<Failure, List<AdminPendingWithdrawalRequestEntity>>>
      getAdminPendingWithdrawalRequest();

  Future<Either<Failure, String>> doInternalTransfer(
      {required InternalTransferEntity internalTransferEntity});
  Future<Either<Failure, String>> followTradeCall(
      {required String tradeCallID});

  Future<Either<Failure, List<TradeEntity>>> listTradesAUserIsFollowing();
  Future<Either<Failure, TradeEntity>> createTradeCallBySuperAdmin(
      {required TradeEntity tradeEntity});
  Future<Either<Failure, List<TradeEntity>>> fetchAllTrades();
  Future<Either<Failure, String>> setWithdrawalPassword(
      {required String withdrawPassword,
      required String withdrawPasswordConfirmation});
  Future<Either<Failure, String>> getpnl();
}
