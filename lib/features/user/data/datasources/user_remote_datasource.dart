import 'package:dio/dio.dart';
import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/features/user/data/models/kyc_request_model.dart';
import 'package:signalwavex/features/user/data/models/referral_code_response_model.dart';
import 'package:signalwavex/features/user/data/models/referral_lists_response_model.dart';
import 'package:signalwavex/features/user/data/models/user_model.dart';
import 'package:signalwavex/features/user/domain/entities/kyc_request_entity.dart';
import 'package:signalwavex/features/user/domain/entities/referral_code_response_entity.dart';
import 'package:signalwavex/features/user/domain/entities/referral_lists_response_entity.dart';
import 'package:signalwavex/features/user/domain/entities/user_entity.dart';

abstract class UserRemoteDatasource {
  Future<UserEntity> getUserDetails();
  Future<String> kycVerification({required KycRequestEntity kycRequestEntity});
  Future<ReferralCodeResponseEntity> getRefferalCode();
  Future<ReferralListsResponseEntity> getRefferalList();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  UserRemoteDatasourceImpl({
    required this.networkClient,
    required this.appPreferenceService,
  });
  final AppPreferenceService appPreferenceService;

  final SignalWalletNetworkClient networkClient;

  @override
  Future<UserEntity> getUserDetails() async {
    // print("debug_print-UserRemoteDatasourceImpl-getUserDetails-called");
    final response = await networkClient.get(
      endpoint: EndpointConstant.fetchAllBalances, // e get as e be
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    // print(
    //     "debug_print-UserRemoteDatasourceImpl-getUserDetails-response.data_is_${response.data}");

    final result = UserModel.fromJson((response.data as Map));
    return result;
  }

  @override
  Future<String> kycVerification(
      {required KycRequestEntity kycRequestEntity}) async {
    KycRequestModel model = KycRequestModel.fromEntity(kycRequestEntity);
    Map<String, dynamic> originaMap = model.toJson();
    final file = await MultipartFile.fromFile(
      kycRequestEntity.docImage!.path,
      filename: kycRequestEntity.docImage!.path.split('/').last,
    );
    originaMap["id_document"] = file;
    final formData = FormData.fromMap(originaMap);

    final response = await networkClient.post(
      endpoint: EndpointConstant.getConversions,
      isAuthHeaderRequired: true,
      returnRawData: true,
      data: formData,
    );

    return response.message;
  }

  @override
  Future<ReferralCodeResponseEntity> getRefferalCode() async {
    final response = await networkClient.get(
      endpoint: EndpointConstant.getRefferalCode,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );

    return ReferralCodeResponseModel.fromJson(response.data);
  }

  @override
  Future<ReferralListsResponseEntity> getRefferalList() async {
    final response = await networkClient.get(
      endpoint: EndpointConstant.getRefferalList,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );

    return ReferralListsResponseModel.fromJson(response.data);
  }
}
