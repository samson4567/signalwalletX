import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/exception.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/core/mapper/failure_mapper.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/datasources/wallet_system_user_balance_and_trade_calling_local_datasource.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/datasources/wallet_system_user_balance_and_trade_calling_remote_datasource.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/admin_pending_withdrawal_request_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/btc_chart_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/deposit_address_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/historical_order_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/internal_transfer_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/order_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_withdrawal_request_request_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_withdrawal_request_response_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/withdraw_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/repositories/wallet_system_user_balance_and_trade_calling_repository.dart';

class WalletSystemUserBalanceAndTradeCallingRepositoryImpl
    implements WalletSystemUserBalanceAndTradeCallingRepository {
  WalletSystemUserBalanceAndTradeCallingRepositoryImpl({
    required this.walletSystemUserBalanceAndTradeCallingRemoteDatasource,
    required this.walletSystemUserBalanceAndTradeCallingLocalDatasource,
  });

  final WalletSystemUserBalanceAndTradeCallingRemoteDatasource
      walletSystemUserBalanceAndTradeCallingRemoteDatasource;
  final WalletSystemUserBalanceAndTradeCallingLocalDatasource
      walletSystemUserBalanceAndTradeCallingLocalDatasource;

  @override
  Future<Either<Failure, List<WalletAccountEntity>>> fetchAllBalances() async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .fetchAllBalances();

      return right([...result]);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, DepositAddressEntity>> retriveDepositAddress(
      {required String chain, required String currency}) async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .retriveDepositAddress(currency: currency, chain: chain);

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, TradeWithdrawalRequestResponseEntity>>
      requestTradeWithdrawal(
          {required TradeWithdrawalRequestRequestEntity
              tradeWithdrawalRequestRequestEntity}) async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .requestTradeWithdrawal(
                  tradeWithdrawalRequestRequestEntity:
                      tradeWithdrawalRequestRequestEntity);

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> adminSetWitdrawal(
      {required String withdrawalFee}) async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .adminSetWitdrawal(withdrawalFee: withdrawalFee);

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<AdminPendingWithdrawalRequestEntity>>>
      getAdminPendingWithdrawalRequest() async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .getAdminPendingWithdrawalRequest();

      return right([...result]);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> doInternalTransfer(
      {required InternalTransferEntity internalTransferEntity}) async {
    print(
        "debug_print-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-doInternalTransfer-started");
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .doInternalTransfer(
                  internalTransferEntity: internalTransferEntity);
      print(
          "debug_print-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-doInternalTransfer-result_is_$result");
      return right(result);
    } catch (e) {
      print(
          "debug_print-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-doInternalTransfer-e_is_${(e as ClientException).message}");
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> followTradeCall(
      {required String tradeCallID}) async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .followTradeCall(tradeCallID: tradeCallID);

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<TradeEntity>>>
      listTradesAUserIsFollowing() async {
    print(
        "dbakbdkajbsdsksbdba-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-listTradesAUserIsFollowing-started");
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .listTradesAUserIsFollowing();
      print(
          "dbakbdkajbsdsksbdba-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-listTradesAUserIsFollowing-result_is_${result}");
      return right(result);
    } catch (e) {
      print(
          "dbakbdkajbsdsksbdba-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-listTradesAUserIsFollowing-e_is_${e}");
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, TradeEntity>> createTradeCallBySuperAdmin(
      {required TradeEntity tradeEntity}) async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .createTradeCallBySuperAdmin(tradeEntity: tradeEntity);

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<TradeEntity>>> fetchAllTrades() async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .fetchAllTrades();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> setWithdrawalPassword({
    required String withdrawPassword,
    required String withdrawPasswordConfirmation,
  }) async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .setWithdrawalPassword(
                  withdrawPassword: withdrawPassword,
                  withdrawPasswordConfirmation: withdrawPasswordConfirmation);

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> getpnl() async {
    print(
        "sdbjashdajsd-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-getpnl-started");
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource.getpnl();
      print(
          "sdbjashdajsd-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-getpnl-result_is>>$result");
      return right(result);
    } catch (e) {
      print(
          "sdbjashdajsd-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-getpnl-error_is>>$e");
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> processWithdrawal({
    required WithdrawEntity withdrawEntity,
  }) async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .processWithdrawal(withdrawEntity: withdrawEntity);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, BtcDataChartEntity>> fetchBtcDataChart({
    required String symbol,
  }) async {
    try {
      // Call the remote datasource to fetch the BTC chart data
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .fetchBtcDataChart(symbol: symbol);

      return right(
          result); // Assuming the result is a String (or adjust accordingly)
    } catch (e) {
      return left(
          mapExceptionToFailure(e)); // Handle any errors and map to Failure
    }
  }

  @override
  Future<Either<Failure, List<HistoricalOrderEntity>>>
      fetchUserTransactions() async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .fetchUserTransactions();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> deleteOrderRequest(
      {required String tradeIdInString,
      required String tradeIdInNumber,
      required String symbol}) async {
    // print(
    //     "hasvhdvashvdja-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-deleteOrderRequest-started");
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .deleteOrderRequest(
                  tradeIdInNumber: tradeIdInNumber,
                  symbol: symbol,
                  tradeIdInString: tradeIdInString);
      // print(
      //     "hasvhdvashvdja-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-deleteOrderRequest-result_is>>${result}");
      return right(result);
    } catch (e) {
      // print(
      //     "hasvhdvashvdja-WalletSystemUserBalanceAndTradeCallingRepositoryImpl-deleteOrderRequest-e_is>>${e}");
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<HistoricalOrderEntity>>>
      fetchUserAllTransactions() async {
    try {
      final result =
          await walletSystemUserBalanceAndTradeCallingRemoteDatasource
              .fetchUserAllTransactions();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
