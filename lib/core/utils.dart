import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_bloc.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_event.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_event.dart';

getAndSetInitialData(BuildContext context) {
  context
      .read<WalletSystemUserBalanceAndTradeCallingBloc>()
      .add(const GetpnlEvent());
  // getUserCoinBalances(context);
  getCoins(context);
}

getUserCoinBalances(BuildContext context) {
  context
      .read<WalletSystemUserBalanceAndTradeCallingBloc>()
      .add(const FetchAllAccountBalanceEvent());
}

getCoins(BuildContext context) {
  context.read<TradingSystemBloc>().add(const GetCoinListEvent());
}

WalletAccountEntity? getCoinWaletDetails(
    BuildContext context, CoinEntity coinEntity) {
  // coinEntity.chains.;
  WalletAccountEntity? result;
  List<WalletAccountEntity> walletAccountEntities =
      context.read<AppBloc>().state.listOfWalletAccounts ?? [];
  walletAccountEntities.forEach((element) {
    if (element.currency == coinEntity.symbol) result = element;
  });
  return result;
}

Uint8List getImageDataFromString(String base64Image) {
  String base64String = base64Image.split(',').last;
  Uint8List bytes = base64.decode(base64String);
  return bytes;
}

String getPerOne(
  String tokenAmount,
  String equivalent,
) {
  String result = '';

  double convertedEquivalent = double.parse(tokenAmount);
  double convertedTokenAmount = double.parse(equivalent);
  result = (convertedEquivalent / convertedTokenAmount).toString();

  return result;
  // return await getDataWidgetList(result, serviceName);
}

// getPerOne

Future<Map<String, dynamic>> requestResources(String url, Object? body,
    Map<String, String> headers, String requestType) async {
  Uri parsedUrl = Uri.parse(url);
  http.Response response;
  if (requestType == 'get') {
    try {
      response = await http
          .get(
        parsedUrl,
        headers: headers,
      )
          .timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          return http.Response(
              json.encode(
                  {"status": false, "message": "timeout check your network"}),
              700);
        },
      );
    } catch (e) {
      response = http.Response(json.encode({"status": false}), 700);
    }
  } else {
    if (requestType == 'encoded_post') {
      String encodedBody = json.encode(body);
      headers["Content-Type"] = "application/json";
      // {"Content-Type": "application/json"}
      try {
        response = await http
            .post(parsedUrl, body: encodedBody, headers: headers)
            .timeout(
          const Duration(minutes: 1),
          onTimeout: () {
            return http.Response(
                json.encode(
                    {"status": false, "message": "timeout check your network"}),
                700);
          },
        );
      } catch (e) {
        response = http.Response(json.encode({"status": false}), 700);
      }
    } else {
      try {
        response = await http
            .post(
          parsedUrl,
          body: body,
          headers: headers,
        )
            .timeout(
          const Duration(minutes: 1),
          onTimeout: () {
            return http.Response(
                json.encode(
                    {"status": false, "message": "timeout check your network"}),
                700);
          },
        );
      } catch (e) {
        response = http.Response(json.encode({"status": false}), 700);
      }
    }
  }

  Map<String, dynamic>? result = (handleJsonResponse(response) is List)
      ? {"result": handleJsonResponse(response)}
      : handleJsonResponse(response);
  return result ?? {};
}

dynamic handleJsonResponse(http.Response response) {
  dynamic jsonResponse;

  jsonResponse = json.decode(response.body);
  if (response.statusCode == 200) {
    jsonResponse = json.decode(response.body);
  } else {
    // avoid_print('Error: ${response.statusCode}');
  }

  try {
    jsonResponse = json.decode(jsonResponse);
  } catch (e) {}

  return jsonResponse;
}

getTrasactionDateFormat(String? dateTimeString) {
  String formattedTime = "-";

  if (dateTimeString != null) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Create a DateFormat object for the desired output format
    DateFormat outputFormat = DateFormat("hh.mm a");

    // Format the DateTime object
    formattedTime = outputFormat.format(dateTime);
  }

  return formattedTime;
}

getSymbolFromName() {}

getCoinImageFromAsset(CoinEntity coinEntity) {
  final List<Map<String, String>> coins = [
    {
      'icon': 'assets/icons/xrp.png',
      'name': 'Ripple',
      'price': '\$96,345.6',
      'percentage': '0.83%',
    },
    {
      'icon': 'assets/icons/ethereum.png',
      'name': 'Ethereum',
      'price': '\$6,345.2',
      'percentage': '1.12%',
    },
    {
      'icon': 'assets/icons/doge.png',
      'name': 'Dogecoin',
      'price': '\$0342.24',
      'percentage': '2.67%',
    },
    {
      'icon': 'assets/icons/sol.png',
      'name': 'Solana',
      'price': '\$0342.24',
      'percentage': '2.67%',
    },
    {
      'icon': 'assets/icons/tele.png',
      'name': 'Toncoin',
      'price': '\$0342.24',
      'percentage': '2.67%',
    },
    {
      'icon': 'assets/icons/lit3.png',
      'name': 'Litecoin',
      'price': '\$0342.24',
      'percentage': '2.67%',
    },
    {
      'icon': 'assets/icons/bitcoin.png',
      'name': 'BITCOIN',
      'price': '\$0342.24',
      'percentage': '2.67%',
    },
    {
      'icon': 'assets/icons/bch.png',
      'name': 'Bitcoin Cash',
      'price': '\$0342.24',
      'percentage': '2.67%',
    },
  ];
  String? result;
  coins.forEach(
    (element) {
      if (element['name']?.toLowerCase() == coinEntity.name?.toLowerCase() &&
          coinEntity.name != null) {
        result = element["icon"];
      }
    },
  );
  return result;
}

Map<String, dynamic>? calculatePriceChange(Map<String, dynamic> data) {
  if (data == null || data.isEmpty) {
    return null;
  }

  double open = double.parse(data['open']);
  double close = double.parse(data['close']);

  double change = close - open;
  double percentageChange = (change / open) * 100;

  return {
    'percentageChange': percentageChange.toStringAsFixed(4),
    'valueChange': change.abs().toStringAsFixed(4),
    'currentPrice': close,
  };
}
