import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/user/data/models/user_model.dart';
import 'package:signalwavex/features/user/domain/entities/user_entity.dart';
import 'package:signalwavex/tradesection/convert.dart';

abstract class CoinRemoteDatasource {
  Future<CoinEntity> getBTCDetail();
  Future<List<CoinEntity>> getTopCoins();
}

class CoinRemoteDatasourceImpl implements CoinRemoteDatasource {
  CoinRemoteDatasourceImpl({
    required this.networkClient,
    required this.appPreferenceService,
  });
  final AppPreferenceService appPreferenceService;

  final SignalWalletNetworkClient networkClient;

  @override
  Future<CoinEntity> getBTCDetail() async {
    final response = await networkClient.get(
      endpoint: EndpointConstant.btcData,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );

    CoinEntity result = CoinModel.fromJson((response.data as Map));
    return result;
  }

  @override
  Future<List<CoinEntity>> getTopCoins() async {
    final response = await networkClient.get(
      endpoint: EndpointConstant.btcData,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );

    List rawList = (response.data as Map)["coins"];
    List<CoinEntity> result = rawList
        .map(
          (e) => CoinModel.fromJson(e),
        )
        .toList();

    return result;
  }
}
