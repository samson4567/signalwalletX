import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/security/secure_key.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/authentication/data/models/recent_transaction_model.dart';
import 'package:signalwavex/features/authentication/domain/entities/language_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/recent_transaction_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/transaction_entity.dart';

abstract class AuthenticationRemoteDatasource {
  Future<String> newUserSignUp({required NewUserRequestModel newUserRequest});
  Future<String> verifySignUp({required String email, required String otp});
  Future<String> verifyPhoneNumber(
    String phoneNumber,
  );

  // sendPhone
  Future<String> resendOtp({required String email});
  Future<void> verifyCode(String verificationId, String otpCode);
  Future<String> registerPhoneNumberAsVerified({required String phoneNumber});

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
      {required name, required phoneNumber, required File profilePicture});
  Future<List<TransactionEntity>> getTransactionHistory({required userId});
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
    Map data = newUserRequest.toJson();
    // print("debug_print-newUserSignUp-started");
    // print("debug_print-newUserSignUp-data_is_${data}");

    if (!(data["email"] as String).contains("@")) {
      data["phone"] = data["email"];
      data.remove("email");
    }
    // print("debug_print-newUserSignUp-afterData_is_${data}");

    final response = await networkClient.post(
      endpoint: EndpointConstant.signUp,
      data: data,
    );
    // print("debug_print-newUserSignUp-response_is_${[
    //   response.data,
    //   response.message,
    //   response.success,
    // ]}");
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
    Map data = {
      "email": email,
      "password": password,
    };
    if (!(data["email"] as String).contains("@")) {
      data["phone"] = data["email"];
      data.remove("email");
    }
    final response = await networkClient.post(
      endpoint: EndpointConstant.login,
      data: data,
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
      endpoint: '${EndpointConstant.recentTransaction}/$userId',
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
  Future<String> updateProfile({
    required dynamic name,
    required dynamic phoneNumber,
    required File profilePicture,
  }) async {
    final file = await MultipartFile.fromFile(
      profilePicture.path,
      filename: profilePicture.path.split('/').last,
    );

    final formData = FormData.fromMap({
      'name': name,
      'phone_number': phoneNumber,
      'profile_picture': file,
    });

    final response = await networkClient.post(
      endpoint: EndpointConstant.userProfile,
      data: formData,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );

    return response.data['message'];
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

  @override
  Future<List<TransactionEntity>> getTransactionHistory(
      {required userId}) async {
    final response = await networkClient.post(
        endpoint: EndpointConstant.tradeOrders, returnRawData: true);
    return response.data;
  }

  @override
  Future<String> verifyPhoneNumber(String phoneNumber) async {
    print("This is the credentials phoneNumber $phoneNumber");
    String? verificationIdtobeTaken;
    int? resendOtPtoken;

    // await _authClient.
    //MAKE SURE THE PHONENUMBER STARTS WITH THEIR COUNTRY CODE.
    //THIS IS THE FUNCTION TO BE CALLED FOR YOU TO HAVE THE VERIFY PHONE NUMBER FUNCTION CALLED.
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        forceResendingToken: resendOtPtoken,
        timeout: const Duration(seconds: 60),
        //WHEN THE VERIFICATION IS COMPLETED.
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text("Logged in automatically")));
          print(
              "This is the verification process being completed##########################");
          //  result = await _authClient.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');
        },
        //THIS IS WHEN THE CODE WOULD BE SENT WITH A VERIFICATION ID HERE AT THE FRONT END.

        codeSent: (String verificationId, int? resendToken) {
          verificationIdtobeTaken = verificationId;
          resendOtPtoken = resendToken;
          print(
              "This is the verificationId sent to me $verificationId *********************************************8");
          print('This is the resendToken being sent also $resendToken');
        },
        codeAutoRetrievalTimeout: (String verificationIdCode) {
          verificationIdtobeTaken = verificationIdCode;
        });

    return verificationIdtobeTaken ?? '';
  }

  @override
  Future<void> verifyCode(String verificationId, String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );
    try {
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      print(user.user?.displayName ?? '');
    } catch (e) {
      print("This is the catched error ${e.toString()}");
    }
  }

  // @override
  // Future<bool> verifySignUpPhoneNumberVersion(
  //     {required PhoneNumberVerifier phoneNumberVerifier,
  //     required String otp}) async {
  //   // PhoneNumberVerifier pnv = PhoneNumberVerifier();
  //   // pnv.sendOTP(phoneNumber);
  //   try {
  //     return await phoneNumberVerifier.confirmOTP(int.parse(otp));
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // @override
  // Future<PhoneNumberVerifier> sendPhoneNumberOTP(
  //     {required String phoneNumber}) async {
  //   PhoneNumberVerifier pnv = PhoneNumberVerifier();
  //   await pnv.sendOTP(phoneNumber);
  //   return pnv;
  // }

  @override
  Future<String> registerPhoneNumberAsVerified(
      {required String phoneNumber}) async {
    final response = await networkClient.post(
      endpoint: EndpointConstant.registerPhoneNumberAsVerified,
      returnRawData: true,
      data: {
        "phone": phoneNumber,
      },
    );
    return response.message;
  }
}
