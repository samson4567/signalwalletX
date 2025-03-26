import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/admin_pending_withdrawal_request_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/deposit_address_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/internal_transfer_Model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/trade_Model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/trade_withdrawal_request_request_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/trade_withdrawal_request_response_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/wallet_account_balance_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/admin_pending_withdrawal_request_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/deposit_address_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/internal_transfer_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_withdrawal_request_request_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_withdrawal_request_response_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';

abstract class WalletSystemUserBalanceAndTradeCallingRemoteDatasource {
  Future<List<WalletAccountBalanceEntity>> fetchAllBalances();
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

// trading_system (Spot Trading, Orders & Market Data)

  Future<String> followTradeCall({required String tradeCallID});

  Future<List<TradeEntity>> listTradesAUserIsFollowing();
  Future<TradeEntity> createTradeCallBySuperAdmin(
      {required TradeEntity tradeEntity});

  Future<List<TradeEntity>> fetchAllTrades();
  Future<String> setWithdrawalPassword(
      {required String withdrawPassword,
      required String withdrawPasswordConfirmation});
  Future<String> getpnl();
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
  Future<List<WalletAccountBalanceEntity>> fetchAllBalances() async {
    final response = await networkClient.get(
        endpoint: EndpointConstant.fetchAllBalances,
        isAuthHeaderRequired: true,
        returnRawData: true);
    List rawList = (response.data as Map)["wallets"];
    List<WalletAccountBalanceEntity> result = rawList
        .map(
          (e) => WalletAccountBalanceModel.fromJson(e),
        )
        .toList();

    return result;
  }

  @override
  Future<DepositAddressEntity> retriveDepositAddress(
      {required String currency, required String chain}) async {
    final response = await networkClient.post(
        endpoint: EndpointConstant.retriveDepositAddress,
        isAuthHeaderRequired: true,
        returnRawData: true,
        data: {
          "currency": currency,
          "chain": chain,
        });
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
        data: {"withdrawal_fee": withdrawalFee});

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
    final response = await networkClient.post(
      endpoint: EndpointConstant.doInternalTransfer,
      isAuthHeaderRequired: true,
      data: (internalTransferEntity as InternalTransferModel).toJson(),
    );

    return response.message;
  }

  @override
  Future<String> followTradeCall({required String tradeCallID}) async {
    final response = await networkClient.post(
        endpoint: EndpointConstant.followTradeCall,
        isAuthHeaderRequired: true,
        data: {"trade_call_id": tradeCallID});

    return response.message;
  }

  @override
  Future<List<TradeEntity>> listTradesAUserIsFollowing() async {
    final response = await networkClient.get(
      endpoint: EndpointConstant.listTradesAUserIsFollowing,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    List rawList = (response.data as Map)["followed_trades"];
    List<TradeEntity> result = rawList
        .map(
          (e) => TradeModel.fromJson(e),
        )
        .toList();

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
}
