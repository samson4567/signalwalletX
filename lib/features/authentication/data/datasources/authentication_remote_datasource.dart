import 'package:dio/dio.dart';

import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/security/secure_key.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/authentication/data/models/recent_transaction_model.dart';
import 'package:signalwavex/features/authentication/domain/entities/language_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/prelogin_detail_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/recent_transaction_entity.dart';

abstract class AuthenticationRemoteDatasource {
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
  Future<Map<String, dynamic>> googleAuth({required String token});
  Future<String> forgetPassword({required String email});
  Future<List<RecentTransactionEntity>> getRecentTransactions(
      {required String userId});
  Future<String> verifyOtp({required String otp});
  Future<String> setNewPassword(
      {required String email,
      required String password,
      required String confirmPassword});
  Future<LanguagesEntity> fetchLanguages({required code, required name});
  Future<Map> uploadGoogleSignInToken({required String token});

  Future<String> updateProfile(
      {required name, required phoneNumber, required profilePicture});
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
  Future<Map<String, dynamic>> googleAuth({required String token}) async {
    try {
      final response = await networkClient.post(
        endpoint: EndpointConstant.googleauth,
        data: {"id_token": token, "provider": "google"},
      );

      if (response.data == null || response.data['user'] == null) {
        throw Exception('Invalid response from server');
      }

      final authToken = response.data['token'];
      if (authToken != null) {
        await appPreferenceService.saveValue(
            SecureKey.loginAuthTokenKey, authToken);

        final refreshToken = response.data['refresh_token'];
        if (refreshToken != null) {
          await appPreferenceService.saveValue(
              SecureKey.loginUserDataKey, refreshToken);
        }
      }

      return response.data;
    } catch (e) {
      if (e is! DioException) {
        throw DioException(
          requestOptions: RequestOptions(path: EndpointConstant.googleauth),
          error: e,
        );
      }
      rethrow;
    }
  }

  @override
  Future<String> forgetPassword({required String email}) async {
    final response = await networkClient.post(
      endpoint:
          EndpointConstant.forgetpassword, // Use your endpoint constant here
      data: {"email": email},
    );
    return response.message;
  }

  @override
  Future<List<RecentTransactionEntity>> getRecentTransactions({
    required String userId,
  }) async {
    final response = await networkClient.get(
      endpoint:
          '${EndpointConstant.recentTransaction}/$userId', // adjust if needed
      isAuthHeaderRequired: true,
    );

    final List<dynamic> data = response.data;
    return data.map((json) => RecentTransactionModel.fromJson(json)).toList();
  }

  @override
  Future<String> verifyOtp({required String otp}) async {
    final response = await networkClient
        .post(endpoint: EndpointConstant.verifyOTP, data: {'otp': otp});
    return response.message;
  }

  @override
  Future<String> setNewPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await networkClient.post(
      endpoint: EndpointConstant.resetPassword,
      data: {
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    );
    return response.message;
  }

  @override
  Future<LanguagesEntity> fetchLanguages({required code, required name}) async {
    final response = await networkClient.get(
      endpoint: EndpointConstant.userLanguages,
    );
    response.data;
    throw ();
  }

  @override
  Future<String> updateProfile(
      {required name, required phoneNumber, required profilePicture}) async {
    final response = await networkClient.post(
      endpoint: EndpointConstant.userProfile,
      isAuthHeaderRequired: true,
    );
    return response.data;
  }

  @override
  Future<Map> uploadGoogleSignInToken({required String token}) async {
    final response = await networkClient.post(
        endpoint: EndpointConstant.uploadGoogleToken,
        returnRawData: true,
        data: {
          "token": token,
        });
    return response.data;
  }
}
// uploadGoogleToken
