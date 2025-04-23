import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/trading_system/domain/entities/place_a_buy_or_sell_order_request_entity.dart';

// PlaceABuyOrSellOrderRequestEntity
class PlaceABuyOrSellOrderRequestModel
    extends PlaceABuyOrSellOrderRequestEntity {
  const PlaceABuyOrSellOrderRequestModel({
    super.side,
    super.symbol,
    super.type,
    super.quantity,
    super.price,
    super.timeInForce,
  });

  Map<String, dynamic> toJson() {
    return {
      "symbol": symbol,
      "side": side,
      "type": type,
      "quantity": quantity,
      "price": price,
      "time_in_force": timeInForce,
    };
  }

  factory PlaceABuyOrSellOrderRequestModel.fromJson(Map jsonMap) {
    return PlaceABuyOrSellOrderRequestModel(
      symbol: jsonMap["symbol"],
      side: jsonMap["side"],
      type: jsonMap["type"],
      quantity: jsonMap["quantity"],
      price: jsonMap["price"],
      timeInForce: jsonMap["time_in_force"],
    );
  }

  factory PlaceABuyOrSellOrderRequestModel.empty(Map jsonMap) {
    return const PlaceABuyOrSellOrderRequestModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}



// {
//     "symbol": "BTCUSDT",
//     "side": "SELL",
//     "type": "LIMIT",
//     "quantity": 0.01,
//     "price": 46000,
//     "time_in_force": "GTC"
// }