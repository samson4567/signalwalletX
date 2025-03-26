import 'package:signalwavex/features/trading_system/domain/entities/live_market_price_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_entity.dart';

// TradeEntity

class LiveMarketPriceModel extends LiveMarketPriceEntity {
  const LiveMarketPriceModel({
    super.price,
    super.symbol,
    super.twentyFourHourChange,
  });

  Map<String, dynamic> toJson() {
    return {
      "symbol": symbol,
      "price": price,
      "24h_change": twentyFourHourChange,
    };
  }

  factory LiveMarketPriceModel.fromJson(Map jsonMap) {
    return LiveMarketPriceModel(
      symbol: jsonMap["symbol"],
      price: jsonMap["price"],
      twentyFourHourChange: jsonMap["24h_change"],
    );
  }

  factory LiveMarketPriceModel.empty(Map jsonMap) {
    return LiveMarketPriceModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}
