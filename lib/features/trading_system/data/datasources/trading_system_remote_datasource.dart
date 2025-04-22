import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/app_variables.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/utils.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';
import 'package:signalwavex/features/trading_system/data/models/conversion_model.dart';

import 'package:signalwavex/features/trading_system/data/models/order_book_model.dart';
import 'package:signalwavex/features/trading_system/data/models/tradeorder_model.dart';

import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/conversion_entity.dart';

import 'package:signalwavex/features/trading_system/domain/entities/order_book_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/place_a_buy_or_sell_order_request_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/tradeorder_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/order_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/order_entity.dart';

abstract class TradingSystemRemoteDatasource {
  Future<OrderBookEntity> fetchOrderBook({required String symbol});
  Future<String> placeABuyOrSellOrderRequest(
      {required PlaceABuyOrSellOrderRequestEntity
          placeABuyOrSellOrderRequestEntity});
  Future<ConversionEntity> convert(
      {required ConversionEntity conversionEntity});
  Future<List<ConversionEntity>> getConversions();
  Future<List<CoinEntity>> getCoins();

  Future<Map<String, dynamic>> getRange(
    String from,
    String to,
  );
  Future<String> getExchangeRate(
    String from,
    String to,
  );

  Future<TraderOrderFollowedEntity> getTraderOrderFollowed(
      {required String tid});
  Future<OrderEntity> fetchActiveTrade();
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

    return response.message;
  }

  @override
  Future<ConversionEntity> convert(
      {required ConversionEntity conversionEntity}) async {
    Map data = (conversionEntity as ConversionModel).toConvertRequestMap();
    final response = await networkClient.post(
        endpoint: EndpointConstant.convert,
        isAuthHeaderRequired: true,
        returnRawData: true,
        data: data);

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
    final response = await networkClient.get(
      endpoint: EndpointConstant.getTradableCoin,
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

  @override
  Future<String> getExchangeRate(String from, String to) async {
    String result = '';

    Map<String, dynamic> range = await getRange(from, to);

// /v3/estimates
    Map<String, dynamic> body = {
      'fixed': 'false',
      'tickerFrom': from,
      'tickerTo': to,
      "networkFrom": from,
      "networkTo": to,
      'amount': range['min']
    };

    Map<String, String> headers = {
      "x-api-key": "0396787a-215a-44b0-8c94-35a020d3b37f"
    };
    headers["Content-Type"] = "application/json";
    http.Response r = await http.get(
        Uri.https("$simpleswapBaseUrl", "/v3/estimates", body),
        headers: headers);
    // estimatedAmount
    dynamic rawResult = jsonDecode(r.body);

    String conversionRate = getPerOne(
        range['min'] as String, rawResult['result']['estimatedAmount']);
    result = '$conversionRate';

    return result;
  }

  @override
  Future<Map<String, dynamic>> getRange(String from, String to) async {
    Map<String, dynamic> result = {};

    Map<String, dynamic> body = {
      'fixed': 'false',
      'tickerFrom': from,
      'tickerTo': to,
      "networkFrom": from,
      "networkTo": to,
      "reverse": "false"
    };
    body;
    Map<String, String> headers = {
      "x-api-key": "0396787a-215a-44b0-8c94-35a020d3b37f"
    };
    headers["Content-Type"] = "application/json";

    http.Response r = await http.get(
        Uri.https(simpleswapBaseUrl, "/v3/ranges", body),
        headers: headers);
    dynamic rawResult = jsonDecode(r.body);

    result = rawResult['result'];

    return result;
  }

  @override
  Future<TraderOrderFollowedEntity> getTraderOrderFollowed(
      {required String tid}) async {
    final response = await networkClient.post(
      endpoint: EndpointConstant.followTradeCall,
      isAuthHeaderRequired: true,
      returnRawData: true,
      data: {
        "tid": tid,
      },
    );

    final data = (response.data as Map<String, dynamic>);
    return TraderOrderFollowedModel.fromJson(data);
  }

  @override
  Future<OrderEntity> fetchActiveTrade() async {
    print("debug_print-fetchActiveTrade-started");

    final response = await networkClient.get(
      endpoint: EndpointConstant.fetchActiveTrade,
      isAuthHeaderRequired: true,
    );
    print("debug_print-fetchActiveTrade-response.data_is_${response.data}");

    OrderModel or = OrderModel.fromJson(response.data);
    print("debug_print-fetchActiveTrade-OrderModel_is_${or}");
    return or;
  }
}














































// Future<String> getExchangeRate(
//   String from,
//   String to,
// ) async {
//   String result = '';

//   Map<String, dynamic> range = await getRange(from, to);

//   Uri url = Uri.https(
//     baseurl,
//     '/get_estimated',
//   );
//   Map<String, dynamic> body = {
//     'fixed': 'false',
//     'currency_from': from,
//     'currency_to': to,
//     'amount': range['min']
//   };

//   dynamic rawResult = await requestResources(
//       "$baseURL/get_estimated", body, {}, "encoded_post");

//   String conversionRate = getPerOne(range['min'] as String, rawResult);
//   result = '1: $conversionRate';

//   return result;
// }

  // @override
  // Future<List<BinanceTicker24hEntity>> fetchBinanceTicker24h() async {
  //   const binanceBaseUrl = "https://api.binance.com/api";

  //   final uri = Uri.https(
  //     binanceBaseUrl,
  //     "https://api.binance.com/api/v3/ticker/24hr?symbol=BTCUSDT",
  //   );

  //   final response = await http.get(uri);

  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = jsonDecode(response.body);
  //     return jsonData
  //         .map((item) => BinanceTicker24hModel.fromJson(item))
  //         .toList();
  //   } else {
  //     throw Exception("Failed to fetch Binance 24h ticker");
  //   }
  // }