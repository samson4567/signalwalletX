import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/security/secure_key.dart';
import 'package:signalwavex/features/app_bloc/data/models/user_model.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';

abstract class AppRemoteDatasource {}

class AppRemoteDatasourceImpl implements AppRemoteDatasource {
  AppRemoteDatasourceImpl({
    required this.networkClient,
    required this.appPreferenceService,
  });
  final AppPreferenceService appPreferenceService;

  final SignalWalletNetworkClient networkClient;
}
