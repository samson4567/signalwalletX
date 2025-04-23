import 'dart:convert';

import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/security/secure_key.dart';
import 'package:signalwavex/features/authentication/data/models/prelogin_detail_model.dart';
import 'package:signalwavex/features/authentication/domain/entities/prelogin_detail_entity.dart';

abstract class AuthenticationLocalDatasource {
  Future<void> clearSession();
  Future<void> saveAuthToken(String token);
  Future<String?> getAuthToken();
  Future<void> clearCachedUserData();
  Future<PreloginDetailEntity> loadPreloginDetail();
  Future savePreloginDetail(
      {required PreloginDetailEntity preloginDetailEntity});
}

class AuthenticationLocalDatasourceImpl
    implements AuthenticationLocalDatasource {
  AuthenticationLocalDatasourceImpl({required this.appPreferenceService});
  final AppPreferenceService appPreferenceService;

  @override
  Future<void> clearSession() async {
    await appPreferenceService.clearAll();
  }

  @override
  Future<String?> getAuthToken() async {
    final token =
        appPreferenceService.getValue<String>(SecureKey.loginAuthTokenKey);
    if (token == null) return null;
    return token;
  }

  @override
  Future<PreloginDetailEntity> loadPreloginDetail() async {
    final preloginDetailRaw =
        appPreferenceService.getValue<String>("preloginDetail");
    // preloginDetailRaw
    PreloginDetailEntity preloginDetailEntity =
        PreloginDetailModel.fromJson(jsonDecode(preloginDetailRaw ?? "{}"));
    return preloginDetailEntity;
  }

  @override
  Future savePreloginDetail(
      {required PreloginDetailEntity preloginDetailEntity}) async {
    final preloginDetailRaw = jsonEncode(
        PreloginDetailModel.fromEntity(preloginDetailEntity).toJson());
    await appPreferenceService.saveValue<String>(
        "preloginDetail", preloginDetailRaw);
  }

  @override
  Future<void> saveAuthToken(String token) async {
    await appPreferenceService.saveValue(SecureKey.loginAuthTokenKey, token);
  }

  @override
  Future<void> clearCachedUserData() async {
    await appPreferenceService.removeValue(SecureKey.loginAuthTokenKey);
  }
}
