import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/security/secure_key.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';
import 'package:signalwavex/features/trading_system/data/models/conversion_model.dart';
import 'package:signalwavex/features/trading_system/data/models/live_market_price_model.dart';
import 'package:signalwavex/features/trading_system/data/models/order_book_model.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/conversion_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/live_market_price_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/order_book_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/place_a_buy_or_sell_order_request_entity.dart';

abstract class TradingSystemRemoteDatasource {
  Future<List<LiveMarketPriceEntity>> fetchLiveMarketPrices();
  Future<OrderBookEntity> fetchOrderBook({required String symbol});
  Future<String> placeABuyOrSellOrderRequest(
      {required PlaceABuyOrSellOrderRequestEntity
          placeABuyOrSellOrderRequestEntity});
  Future<ConversionEntity> convert(
      {required ConversionEntity conversionEntity});
  Future<List<ConversionEntity>> getConversions();
  Future<List<CoinEntity>> getCoins();
}

class TradingSystemRemoteDatasourceImpl
    implements TradingSystemRemoteDatasource {
  TradingSystemRemoteDatasourceImpl({
    required this.networkClient,
    required this.appPreferenceService,
  });
  final AppPreferenceService appPreferenceService;

  final SignalWalletNetworkClient networkClient;

  @override
  Future<List<LiveMarketPriceEntity>> fetchLiveMarketPrices() async {
    // fetchLiveMarketPrices
    final response = await networkClient.get(
      endpoint: EndpointConstant.fetchLiveMarketPrices,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    List rawList = (response.data as Map)["trade_calls"];
    List<LiveMarketPriceEntity> result = rawList
        .map(
          (e) => LiveMarketPriceModel.fromJson(e),
        )
        .toList();

    return result;
  }

  @override
  Future<OrderBookEntity> fetchOrderBook({required String symbol}) async {
    final response = await networkClient.get(
        endpoint: EndpointConstant.fetchOrderBook,
        isAuthHeaderRequired: true,
        returnRawData: true,
        params: {"symbol": symbol});

    OrderBookModel result = OrderBookModel.fromJson((response.data as Map));

    return result;
  }

  @override
  Future<String> placeABuyOrSellOrderRequest(
      {required PlaceABuyOrSellOrderRequestEntity
          placeABuyOrSellOrderRequestEntity}) async {
    final response = await networkClient.post(
      endpoint: EndpointConstant.placeABuyOrSellOrderRequest,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );

// TODO the success message is still missing ask the backend and display appropriate info
    return response.message;
  }

  @override
  Future<ConversionEntity> convert(
      {required ConversionEntity conversionEntity}) async {
    final response = await networkClient.get(
        endpoint: EndpointConstant.convert,
        isAuthHeaderRequired: true,
        returnRawData: true,
        params: (conversionEntity as ConversionModel).toConvertRequestMap());

    ConversionModel result =
        ConversionModel.fromConvertResponseMap((response.data as Map));

    return result;
  }

  @override
  Future<List<ConversionEntity>> getConversions() async {
    final response = await networkClient.get(
      endpoint: EndpointConstant.getConversions,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    List rawList = (response.data as Map)["conversions"];
    List<ConversionEntity> result = rawList
        .map(
          (e) => ConversionModel.fromJson(e),
        )
        .toList();

    return result;
  }

  @override
  Future<List<CoinEntity>> getCoins() async {
    print("debug_print_TradingSystemRemoteDatasourceImpl-getCoins-start");
    final response = await networkClient.get(
      endpoint: EndpointConstant.getTradableCoin,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    print("debug_print_TradingSystemRemoteDatasourceImpl-response_gotten${[
      response.data,
      response.message
    ]}");
    List rawList = (response.data as Map)["coins"];
    List<CoinEntity> result = rawList
        .map(
          (e) => CoinModel.fromJson(e),
        )
        .toList();
    print("debug_print_TradingSystemRemoteDatasourceImpl-processed_result_is${[
      rawList,
      result,
    ]}");

    return result;
  }
}
