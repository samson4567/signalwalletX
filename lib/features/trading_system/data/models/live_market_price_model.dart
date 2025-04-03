import 'package:signalwavex/features/trading_system/domain/entities/live_market_price_entity.dart';

// TradeEntity

class LiveMarketPriceModel extends LiveMarketPriceEntity {
  const LiveMarketPriceModel({
    super.price,
    super.symbol,
    super.twentyFourHourChange,
    super.didIncrease,
  });

  Map<String, dynamic> toJson() {
    return {
      "symbol": symbol,
      "price": price,
      "24h_change": twentyFourHourChange,
      "didIncrease": didIncrease,
    };
  }

  factory LiveMarketPriceModel.fromJson(Map jsonMap) {
    bool inced = (jsonMap["24h_change"] as String?)?.startsWith("-") ?? false;
    return LiveMarketPriceModel(
        symbol: jsonMap["symbol"],
        price: jsonMap["price"],
        twentyFourHourChange: jsonMap["24h_change"],
        didIncrease: inced);
  }

  factory LiveMarketPriceModel.empty(Map jsonMap) {
    return LiveMarketPriceModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}
