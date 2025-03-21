import 'package:dio/dio.dart';
import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/security/secure_key.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';

abstract class AuthenticationRemoteDatasource {
  Future<String> newUserSignUp({required NewUserRequestModel newUserRequest});
  Future<String> verifySignUp({required String email, required String otp});
  Future<String> resendOtp({required String email});
  Future<String> login({required String email, required String password});
  Future<String> logout({required String token});
}

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  AuthenticationRemoteDatasourceImpl({
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
  Future<String> login(
      {required String email, required String password}) async {
    // appPreferenceService.clearAll();
    final response = await networkClient.post(
      endpoint: EndpointConstant.login,
      data: {
        "email": email,
        "password": password,
      },
    );
    if (response.data?["token"]?.isNotEmpty ?? false) {
      await appPreferenceService.saveValue<String>(
          SecureKey.loginAuthTokenKey, response.data["token"]);
    }

    return response.message;
  }

  @override
  Future<String> logout({required String token}) async {
    String? _token = await appPreferenceService
        .getValue<String>(SecureKey.loginAuthTokenKey);

    final response = await networkClient.post(
      endpoint: EndpointConstant.logout,
      isAuthHeaderRequired: true,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
    return response.message;
  }
}
