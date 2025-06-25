import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';

abstract class CoinRemoteDatasource {
  Future<CoinEntity> getBTCDetail();
  Future<List<CoinEntity>> getTopCoins();
  Future<List<CoinEntity>> getMarketCoins();
  Future<String?> fetchCoinPrice({required String tradPairSymbol});
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

    print("klsabdhbadhab-${result}");
    return result;
  }

  @override
  Future<List<CoinEntity>> getTopCoins() async {
    final response = await networkClient.get(
      endpoint: EndpointConstant.topCoin,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );

    List rawList = (response.data as Map)["coins"];

    List<CoinEntity> result = rawList
        .map(
          (e) => CoinModel.fromJson(e),
        )
        .toList();
    print("ssdbaldbjkasbdbasdhbs-${result}");
    return result;
  }

  @override
  Future<List<CoinEntity>> getMarketCoins() async {
    print("bdhbjfhbsdjfbjs-getMarketCoins-started");
    final response = await networkClient.get(
      endpoint: EndpointConstant.marketCoin,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    print("bdhbjfhbsdjfbjs-getMarketCoins-response_gotten");
    print("bdhbjfhbsdjfbjs-getMarketCoins-response.data_is>>${response.data}");
    List rawList = (response.data as Map)["coins"];
    print("bdhbjfhbsdjfbjs-getMarketCoins-rawList_is>>${rawList}");
    List<CoinEntity> result = rawList
        .map(
          (e) => CoinModel.fromJson(e),
        )
        .toList();
    print("bdhbjfhbsdjfbjs-getMarketCoins-result_is>>${result}");

    return result;
  }

  @override
  Future<String?> fetchCoinPrice({required String tradPairSymbol}) async {
    print("debug_print-CoinRemoteDatasourceImpl-fetchCoinPrice-started");
    final response = await networkClient.get(
      endpoint: EndpointConstant.fetchCoinPrice + tradPairSymbol,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    print(
        "debug_print-CoinRemoteDatasourceImpl-fetchCoinPrice-response.data_is_${response.data}");

    return (response.data as Map)["liveKline"]["closePrice"]?.toString();
  }
}
