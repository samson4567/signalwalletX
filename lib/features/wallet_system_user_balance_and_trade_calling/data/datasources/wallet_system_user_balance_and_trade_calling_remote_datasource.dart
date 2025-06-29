import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/admin_pending_withdrawal_request_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/btc_chart_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/deposit_address_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/historical_order_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/internal_transfer_Model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/order_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/trade_Model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/trade_withdrawal_request_request_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/trade_withdrawal_request_response_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/wallet_account_balance_model.dart';
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

abstract class WalletSystemUserBalanceAndTradeCallingRemoteDatasource {
  Future<List<WalletAccountEntity>> fetchAllBalances();
  Future<DepositAddressEntity> retriveDepositAddress(
      {required String currency, required String chain});
  Future<TradeWithdrawalRequestResponseEntity> requestTradeWithdrawal(
      {required TradeWithdrawalRequestRequestEntity
          tradeWithdrawalRequestRequestEntity});
  Future<String> adminSetWitdrawal({required String withdrawalFee});
  Future<List<AdminPendingWithdrawalRequestEntity>>
      getAdminPendingWithdrawalRequest();
  Future<String> doInternalTransfer(
      {required InternalTransferEntity internalTransferEntity});
  Future<OrderEntity> followTradeCall({required String tradeCallID});
  Future<List<TradeEntity>> listTradesAUserIsFollowing();
  Future<TradeEntity> createTradeCallBySuperAdmin(
      {required TradeEntity tradeEntity});

  Future<List<TradeEntity>> fetchAllTrades();
  Future<String> setWithdrawalPassword(
      {required String withdrawPassword,
      required String withdrawPasswordConfirmation});
  Future<String> getpnl();
  Future<String> processWithdrawal({required WithdrawEntity withdrawEntity});

  Future<BtcDataChartEntity> fetchBtcDataChart({required String symbol});
  Future<List<HistoricalOrderEntity>> fetchUserTransactions();
  Future<List<HistoricalOrderEntity>> fetchUserAllTransactions();

  Future<String> deleteOrderRequest({
    required String tradeIdInNumber,
    required String tradeIdInString,
    required String symbol,
  });
}

class WalletSystemUserBalanceAndTradeCallingRemoteDatasourceImpl
    implements WalletSystemUserBalanceAndTradeCallingRemoteDatasource {
  WalletSystemUserBalanceAndTradeCallingRemoteDatasourceImpl({
    required this.networkClient,
    required this.appPreferenceService,
  });
  final AppPreferenceService appPreferenceService;

  final SignalWalletNetworkClient networkClient;
  @override
  Future<List<WalletAccountEntity>> fetchAllBalances() async {
    final response = await networkClient.get(
        endpoint: EndpointConstant.fetchAllBalances,
        isAuthHeaderRequired: true,
        returnRawData: true);
    List rawList = (response.data as Map)["wallets"];
    List<WalletAccountEntity> result = rawList
        .map(
          (e) => WalletAccountModel.fromJson(e),
        )
        .toList();
    print("sabdasbdjabsdhbasdjhas-${result}");

    return result;
  }

  @override
  Future<DepositAddressEntity> retriveDepositAddress(
      {required String currency, required String chain}) async {
    // print(
    //     "debug_print-WalletSystemUserBalanceAndTradeCallingRemoteDatasource-retriveDepositAddress-started");
    // print(
    //     "debug_print-WalletSystemUserBalanceAndTradeCallingRemoteDatasource-retriveDepositAddress-input_is_${[
    //   currency,
    //   chain
    // ]}");
    final response = await networkClient.post(
      endpoint: EndpointConstant.retriveDepositAddress,
      isAuthHeaderRequired: true,
      returnRawData: true,
      data: {
        "currency": currency,
        "chain": chain.toLowerCase(),
      },
    );
    print(
        "debug_print-WalletSystemUserBalanceAndTradeCallingRemoteDatasource-retriveDepositAddress-response_is_${[
      response.data,
      response.message,
    ]}");
    DepositAddressModel result = DepositAddressModel.fromJson(response.data);
    return result;
  }

  @override
  Future<TradeWithdrawalRequestResponseEntity> requestTradeWithdrawal(
      {required TradeWithdrawalRequestRequestEntity
          tradeWithdrawalRequestRequestEntity}) async {
    final response = await networkClient.post(
        endpoint: EndpointConstant.tradeWithdrawRequest,
        isAuthHeaderRequired: true,
        returnRawData: true,
        data: (tradeWithdrawalRequestRequestEntity
                as TradeWithdrawalRequestRequestModel)
            .toJson());
    TradeWithdrawalRequestResponseModel result =
        TradeWithdrawalRequestResponseModel.fromJson(response.data);
    return result;
  }

  @override
  Future<String> adminSetWitdrawal({required String withdrawalFee}) async {
    final response = await networkClient.post(
        endpoint: EndpointConstant.adminSetCharges,
        isAuthHeaderRequired: true,
        data: {
          "withdrawal_fee": withdrawalFee,
        });

    return response.message;
  }

  @override
  Future<List<AdminPendingWithdrawalRequestEntity>>
      getAdminPendingWithdrawalRequest() async {
    final response = await networkClient.get(
        endpoint: EndpointConstant.getAdminPendingWithdrawalRequest,
        isAuthHeaderRequired: true,
        returnRawData: true);
    List rawList = (response.data as Map)["pending_withdrawals"];
    List<AdminPendingWithdrawalRequestEntity> result = rawList
        .map(
          (e) => AdminPendingWithdrawalRequestModel.fromJson(e),
        )
        .toList();

    return result;
  }

  @override
  Future<String> doInternalTransfer(
      {required InternalTransferEntity internalTransferEntity}) async {
    // print(
    //     "debug_print-WalletSystemUserBalanceAndTradeCallingRemoteDatasourceImpl-doInternalTransfer-starterd");
    // print(
    //     "debug_print-WalletSystemUserBalanceAndTradeCallingRemoteDatasourceImpl-doInternalTransfer-input_is_${InternalTransferModel.fromEntity(internalTransferEntity).toInternalTransferJson()}");
    final response = await networkClient.post(
      endpoint: EndpointConstant.doInternalTransfer,
      isAuthHeaderRequired: true,
      data: InternalTransferModel.fromEntity(internalTransferEntity)
          .toInternalTransferJson(),
    );
    // print(
    //     "debug_print-WalletSystemUserBalanceAndTradeCallingRemoteDatasourceImpl-doInternalTransfer-response_is_${[
    //   response.data,
    //   response.message,
    // ]}");

    return response.message;
  }

  @override
  Future<OrderEntity> followTradeCall({required String tradeCallID}) async {
    final response = await networkClient.post(
        endpoint: EndpointConstant.followTradeCall,
        isAuthHeaderRequired: true,
        returnRawData: true,
        data: {"tid": tradeCallID});

    final result =
        OrderModel.fromJson(response.data["trade_call"] as Map? ?? {});
    return result;
  }

  @override
  Future<List<TradeEntity>> listTradesAUserIsFollowing() async {
    // print(
    //     "dbakbdkajbsdsksbdba-WalletSystemUserBalanceAndTradeCallingRemoteDatasourceImpl-started");
    final response = await networkClient.get(
      endpoint: EndpointConstant.listTradesAUserIsFollowing,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    // print(
    //     "dbakbdkajbsdsksbdba-WalletSystemUserBalanceAndTradeCallingRemoteDatasourceImpl-response.data_is>>${response.data}");
    List rawList = (response.data as Map)["followed_trades"];
    // print(
    //     "dbakbdkajbsdsksbdba-WalletSystemUserBalanceAndTradeCallingRemoteDatasourceImpl-rawList_is>>${rawList}");
    List<TradeEntity> result = rawList
        .map(
          (e) => TradeModel.fromJson(e),
        )
        .toList();
    // print(
    //     "dbakbdkajbsdsksbdba-WalletSystemUserBalanceAndTradeCallingRemoteDatasourceImpl-result_is>>${result}");
    return result;
  }

  @override
  Future<TradeEntity> createTradeCallBySuperAdmin(
      {required TradeEntity tradeEntity}) async {
    final response = await networkClient.post(
      endpoint: EndpointConstant.createTradeCallBySuperAdmin,
      isAuthHeaderRequired: true,
      returnRawData: true,
      data: (tradeEntity as TradeModel).toSuperAdmintradeCallRequestMap(),
    );

    TradeEntity result =
        TradeModel.fromJson((response.data as Map)["trade_call"]);
    return result;
  }

  @override
  Future<List<TradeEntity>> fetchAllTrades() async {
    final response = await networkClient.get(
      endpoint: EndpointConstant.fetchAllTrades,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    List rawList = (response.data as Map)["trade_calls"];
    List<TradeEntity> result = rawList
        .map(
          (e) => TradeModel.fromJson(e),
        )
        .toList();

    return result;
  }

  @override
  Future<String> setWithdrawalPassword(
      {required String withdrawPassword,
      required String withdrawPasswordConfirmation}) async {
    final response = await networkClient.post(
        endpoint: EndpointConstant.setWithdrawalPassword,
        isAuthHeaderRequired: true,
        data: {
          "withdraw_password": withdrawPassword,
          "withdraw_password_confirmation": withdrawPasswordConfirmation
        });

    return response.message;
  }

  @override
  Future<String> getpnl() async {
    final response = await networkClient.get(
        endpoint: EndpointConstant.getpnl,
        isAuthHeaderRequired: true,
        returnRawData: true);

    return response.data["pnl"];
  }

  @override
  Future<String> processWithdrawal({
    required WithdrawEntity withdrawEntity,
  }) async {
    try {
      final response = await networkClient.post(
        endpoint: EndpointConstant.tradeWithdrawRequest,
        data: {
          "amount": withdrawEntity.amount,
          "chain": withdrawEntity.chain,
          "currency": withdrawEntity.currency,
          "address": withdrawEntity.withdrawAddress,
        },
        isAuthHeaderRequired: true,
        returnRawData: true,
      );

      return response.data["message"];
    } catch (e) {
      throw Exception("Error processing withdrawal: $e");
    }
  }

  @override
  Future<BtcDataChartEntity> fetchBtcDataChart({required String symbol}) async {
    final response = await networkClient.get(
      endpoint: EndpointConstant.btcData,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    print(response.data);
    final result = BtcDataChartModel.fromJson(response.data);
    return result;
  }

  @override
  Future<List<HistoricalOrderEntity>> fetchUserTransactions() async {
    print(
        "*************************************************************************************************8dbfjsdjfbdsbkf-fetchUserTransactions-started");
    final response = await networkClient.get(
        endpoint: EndpointConstant.fetchCompletedTrade,
        isAuthHeaderRequired: true,
        returnRawData: true,
        params: {"range": "today"});
    print(
        "dbfjsdjfbdsbkf-fetchUserTransactions-response.data_is_%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%${response.data}");
    List rawList = (response.data as Map)["history"];
    print(
        "dbfjsdjfbdsbkf-fetchUserTransactions-rawList_is_${rawList}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    List<HistoricalOrderEntity> result = rawList
        .map(
          (e) => HistoricalOrderModel.fromJson(e),
        )
        .toList();
    print(
        "dbfjsdjfbdsbkf-fetchUserTransactions-result_is_**********************-------------------------------------------------------------------------------${result}");

    return result;
  }

  @override
  Future<List<HistoricalOrderEntity>> fetchUserAllTransactions() async {
    print(
        "*************************************************************************************************8dbfjsdjfbdsbkf-fetchUserTransactions-started");
    final response = await networkClient.get(
        endpoint: EndpointConstant.fetchCompletedTrade,
        isAuthHeaderRequired: true,
        returnRawData: true,
        params: {"range": "all"});
    print(
        "dbfjsdjfbdsbkf-fetchUserTransactions-response.data_is_%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%${response.data}");
    List rawList = (response.data as Map)["history"];
    print(
        "dbfjsdjfbdsbkf-fetchUserTransactions-rawList_is_${rawList}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    List<HistoricalOrderEntity> result = rawList
        .map(
          (e) => HistoricalOrderModel.fromJson(e),
        )
        .toList();
    print(
        "dbfjsdjfbdsbkf-fetchUserTransactions-result_is_**********************-------------------------------------------------------------------------------${result}");

    return result;
  }

  @override
  Future<String> deleteOrderRequest({
    required String tradeIdInNumber,
    required String tradeIdInString,
    required String symbol,
  }) async {
    print(
        "hasvhdvashvdja-WalletSystemUserBalanceAndTradeCallingRemoteDatasource-deleteOrderRequest-started");
    final response = await networkClient.delete(
      endpoint:
          "${EndpointConstant.deleteOrderRequest}/${tradeIdInNumber}?symbol=${symbol}&tid=${tradeIdInString}",
      isAuthHeaderRequired: true,
      // returnRawData: true,
    );
    print(
        "hasvhdvashvdja-WalletSystemUserBalanceAndTradeCallingRemoteDatasource-deleteOrderRequest-response.message_is_${response.message}");

    return response.message;
  }
}
