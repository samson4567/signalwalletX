import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/security/secure_key.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/trading_system/data/models/live_market_price_model.dart';
import 'package:signalwavex/features/trading_system/domain/entities/live_market_price_entity.dart';

abstract class TradingSystemRemoteDatasource {
  Future<String> newUserSignUp({required NewUserRequestModel newUserRequest});
  Future<String> verifySignUp({required String email, required String otp});
  Future<String> resendOtp({required String email});
  Future<Map> login({required String email, required String password});
  Future<String> logout({required String token});
  Future<String> updatePassword({
    required String currentPassword,
    required String newPassword,
    required newPasswordConfirmation,
  });
  Future<List<LiveMarketPriceEntity>> fetchLiveMarketPrices();
}

class TradingSystemRemoteDatasourceImpl
    implements TradingSystemRemoteDatasource {
  TradingSystemRemoteDatasourceImpl({
    required this.networkClient,
    required this.appPreferenceService,
  });
  final AppPreferenceService appPreferenceService;

  final SignalWalletNetworkClient networkClient;

  @override
  Future<String> newUserSignUp(
      {required NewUserRequestModel newUserRequest}) async {
    final response = await networkClient.post(
      endpoint: EndpointConstant.signUp,
      data: newUserRequest.toJson(),
    );
    return response.message;
  }

  @override
  Future<String> verifySignUp(
      {required String email, required String otp}) async {
    final response = await networkClient.post(
      endpoint: EndpointConstant.verifySignUp,
      data: {
        "email": email,
        "otp": otp,
      },
    );
    return response.message;
  }

  @override
  Future<String> resendOtp({required String email}) async {
    final response = await networkClient.post(
      endpoint: EndpointConstant.resendOtp,
      data: {
        "email": email,
      },
    );
    return response.message;
  }

  @override
  Future<Map> login({required String email, required String password}) async {
    final response = await networkClient.post(
      endpoint: EndpointConstant.login,
      data: {
        "email": email,
        "password": password,
      },
    );

    return response.data;
  }

  @override
  Future<String> logout({required String token}) async {
    appPreferenceService.getValue<String>(SecureKey.loginAuthTokenKey);

    final response = await networkClient.post(
      endpoint: EndpointConstant.logout,
      isAuthHeaderRequired: true,
    );
    return response.message;
  }

  @override
  Future<String> updatePassword({
    required String currentPassword,
    required String newPassword,
    required newPasswordConfirmation,
  }) async {
    final response = await networkClient.post(
      endpoint: EndpointConstant.updatePassword,
      isAuthHeaderRequired: true,
      data: {
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
      },
    );
    return response.message;
  }

  @override
  Future<List<LiveMarketPriceEntity>> fetchLiveMarketPrices() async {
    // fetchLiveMarketPrices
    final response = await networkClient.get(
      endpoint: EndpointConstant.fetchLiveMarketPrices,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    List rawList = (response.data as Map)["trade_calls"];
    List<LiveMarketPriceEntity> result = rawList
        .map(
          (e) => LiveMarketPriceModel.fromJson(e),
        )
        .toList();

    return result;
  }
}
