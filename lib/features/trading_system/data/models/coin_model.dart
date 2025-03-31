import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';

class CoinModel extends CoinEntity {
  const CoinModel({
    super.chains,
    super.symbol,
    super.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "chains": chains,
      "symbol": symbol,
      "name": name,
    };
  }

  factory CoinModel.fromJson(Map jsonMap) {
    return CoinModel(
      chains: [...((jsonMap["chains"] as List?) ?? [])],
      symbol: jsonMap["symbol"],
      name: jsonMap["name"],
    );
  }

  factory CoinModel.empty() {
    return CoinModel();
  }

  factory CoinModel.createFromLogin(Map jsonMap) {
    return CoinModel(
      chains: jsonMap["chains"],
      symbol: jsonMap["symbol"],
      name: jsonMap["name"],
    );
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}


// {
//             "symbol": "USDT",
//             "name": "Tether",
//             "chains": [
//                 "BSC",
//                 "TRX",
//                 "ETH"
//             ]
//         },