import 'package:signalwavex/core/db/app_preference_service.dart';

abstract class AuthenticationLocalDatasource {}

class AuthenticationLocalDatasourceImpl
    implements AuthenticationLocalDatasource {
  AuthenticationLocalDatasourceImpl({required this.appPreferenceService});
  final AppPreferenceService appPreferenceService;
}
