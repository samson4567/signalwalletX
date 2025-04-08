import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';

abstract class CoinRemoteDatasource {
  Future<CoinEntity> getBTCDetail();
  Future<List<CoinEntity>> getTopCoins();
  Future<List<CoinEntity>> getMarketCoins();
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
    print("debug_print_CoinRepositoryImpl-getBTCDetails-started");
    final response = await networkClient.get(
      endpoint: EndpointConstant.btcData,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    print("debug_print_CoinRepositoryImpl-getBTCDetails-response_is_$response");
    print(
        "debug_print_CoinRepositoryImpl-getBTCDetails-response_raw_data_is_${response.data}");

    CoinEntity result = CoinModel.fromJson((response.data as Map));
    print("debug_print_CoinRepositoryImpl-getBTCDetails-result_is_$result");
    return result;
  }

  @override
  Future<List<CoinEntity>> getTopCoins() async {
    print("debug_print_CoinRepositoryImpl-getTopCoins-started");
    final response = await networkClient.get(
      endpoint: EndpointConstant.topCoin,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    print("debug_print_CoinRepositoryImpl-getTopCoins-response_is_$response");

    List rawList = (response.data as Map)["coins"];
    print("debug_print_CoinRepositoryImpl-getTopCoins-rawList_is_$rawList");
    List<CoinEntity> result = rawList
        .map(
          (e) => CoinModel.fromJson(e),
        )
        .toList();
    print("debug_print_CoinRepositoryImpl-getTopCoins-result_is_$result");
    return result;
  }

  @override
  Future<List<CoinEntity>> getMarketCoins() async {
    final response = await networkClient.get(
      endpoint: EndpointConstant.marketCoin,
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
