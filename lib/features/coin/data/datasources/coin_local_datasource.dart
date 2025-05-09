import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/security/secure_key.dart';

abstract class CoinLocalDatasource {
  Future<void> clearSession();
  Future<void> saveAuthToken(String token);
  Future<String?> getAuthToken();
  Future<void> clearCachedUserData();
}

class CoinLocalDatasourceImpl implements CoinLocalDatasource {
  CoinLocalDatasourceImpl({required this.appPreferenceService});
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
  Future<void> saveAuthToken(String token) async {
    await appPreferenceService.saveValue(SecureKey.loginAuthTokenKey, token);
  }

  @override
  Future<void> clearCachedUserData() async {
    await appPreferenceService.removeValue(SecureKey.loginAuthTokenKey);
  }
}
