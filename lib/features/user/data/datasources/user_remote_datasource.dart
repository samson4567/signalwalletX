import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/features/user/data/models/user_model.dart';
import 'package:signalwavex/features/user/domain/entities/user_entity.dart';

abstract class UserRemoteDatasource {
  Future<UserEntity> getUserDetails();
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
    final response = await networkClient.get(
      endpoint: EndpointConstant.getConversions,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );

    final result = UserModel.fromJson((response.data as Map));
    return result;
  }
}
