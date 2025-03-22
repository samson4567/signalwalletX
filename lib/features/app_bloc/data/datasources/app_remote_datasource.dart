import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';

abstract class AppRemoteDatasource {}

class AppRemoteDatasourceImpl implements AppRemoteDatasource {
  AppRemoteDatasourceImpl({
    required this.networkClient,
    required this.appPreferenceService,
  });
  final AppPreferenceService appPreferenceService;

  final SignalWalletNetworkClient networkClient;
}
