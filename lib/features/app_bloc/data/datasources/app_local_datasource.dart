import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/security/secure_key.dart';

abstract class AppLocalDatasource {}

class AppLocalDatasourceImpl implements AppLocalDatasource {
  AppLocalDatasourceImpl({required this.appPreferenceService});
  final AppPreferenceService appPreferenceService;
}
