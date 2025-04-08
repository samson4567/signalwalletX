import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';

class CoinModel extends CoinEntity {
  const CoinModel({
    super.chains,
    super.symbol,
    super.name,
    super.imagePath,
    super.percentIncrease,
    super.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "chains": chains,
      "symbol": symbol,
      "name": name,
      "imagePath": imagePath,
      "percent_increase": percentIncrease,
      "price": price,
    };

    // {
    //   "chains": chains,
    //   "symbol": symbol,
    //   "name": name,
    // };
  }

  factory CoinModel.fromJson(Map jsonMap) {
    return CoinModel(
      chains: [...((jsonMap["chains"] as List?) ?? [])],
      symbol: jsonMap["symbol"],
      name: jsonMap["name"],
      imagePath: jsonMap['imagePath'],
      percentIncrease: jsonMap['percent_increase'].toString(),
      price: jsonMap['price'].toString(),
    );
  }

  factory CoinModel.empty() {
    return CoinModel();
  }

  factory CoinModel.fromEntity(CoinEntity coinEntity) {
    return CoinModel(
      chains: coinEntity.chains,
      name: coinEntity.name,
      symbol: coinEntity.symbol,
      imagePath: coinEntity.imagePath,
      percentIncrease: coinEntity.percentIncrease,
      price: coinEntity.price,
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