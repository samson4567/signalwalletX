import 'package:signalwavex/core/db/app_preference_service.dart';

abstract class AuthenticationLocalDatasource {
  Future<void> clearSession();
}

class AuthenticationLocalDatasourceImpl
    implements AuthenticationLocalDatasource {
  AuthenticationLocalDatasourceImpl({required this.appPreferenceService});
  final AppPreferenceService appPreferenceService;

  @override
  Future<void> clearSession() async {
    await appPreferenceService.clearAll();
  }
}
