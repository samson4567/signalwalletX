import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:signalwavex/core/api/signalwalletX_network_client.dart';
import 'package:signalwavex/core/app_variables.dart';
import 'package:signalwavex/core/constants/endpoint_constant.dart';
import 'package:signalwavex/core/db/app_preference_service.dart';
import 'package:signalwavex/core/security/secure_key.dart';
import 'package:signalwavex/core/utils.dart';
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

  Future<Map<String, dynamic>> getRange(
    String from,
    String to,
  );
  Future<String> getExchangeRate(
    String from,
    String to,
  );
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
    print(
        "debug_print_TradingSystemRemoteDatasource-fetchLiveMarketPrices-start");
    final response = await networkClient.get(
      endpoint: EndpointConstant.fetchLiveMarketPrices,
      isAuthHeaderRequired: true,
      returnRawData: true,
    );
    print(
        "debug_print_TradingSystemRemoteDatasource-fetchLiveMarketPrices-response${response}");
    List rawList = (response.data as List);
    print(
        "debug_print_TradingSystemRemoteDatasource-fetchLiveMarketPrices-rawList${rawList}");
    List<LiveMarketPriceEntity> result = rawList
        .map(
          (e) => LiveMarketPriceModel.fromJson(e),
        )
        .toList();
    print(
        "debug_print_TradingSystemRemoteDatasource-fetchLiveMarketPrices-result${result}");
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

  @override
  Future<String> getExchangeRate(String from, String to) async {
    String result = '';
    print("sdkjdkasdjsadkjhasjdhasj-getExchangeRate-start");
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

    // dynamic rawResult = await requestResources(
    //     "$simpleswapBaseUrl/v3/estimates", body, {}, "encoded_post");
    Map<String, String> headers = {
      "x-api-key": "0396787a-215a-44b0-8c94-35a020d3b37f"
    };
    headers["Content-Type"] = "application/json";
    http.Response r = await http.get(
        Uri.https("$simpleswapBaseUrl", "/v3/estimates", body),
        headers: headers);
    // estimatedAmount
    dynamic rawResult = jsonDecode(r.body);
    print("sdkjdkasdjsadkjhasjdhasj-getExchangeRate-rawResult${rawResult}");
    String conversionRate = getPerOne(
        range['min'] as String, rawResult['result']['estimatedAmount']);
    result = '$conversionRate';

    return result;
  }

  @override
  Future<Map<String, dynamic>> getRange(String from, String to) async {
    Map<String, dynamic> result = {};
    print("sdkjdkasdjsadkjhasjdhasj-getRange-start");

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
        Uri.https("$simpleswapBaseUrl", "/v3/ranges", body),
        headers: headers);
    dynamic rawResult = jsonDecode(r.body);
    // await requestResources(
    //     "$simpleswapBaseUrl/get_range", body, {}, "encoded_post");

    print("sdkjdkasdjsadkjhasjdhasj-getRange-rawResult${rawResult}");

    result = rawResult['result'];
    //https://api.simpleswap.io/v3/ranges?
    //fixed=false&
    //tickerFrom=btc&
    //tickerTo=eth&
    //networkFrom=btc&
    //networkTo=eth&
    //reverse=false

    return result;
  }
}
