import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/trading_system/domain/entities/order_book_entity.dart';

// OrderBookEntity
class OrderBookModel extends OrderBookEntity {
  const OrderBookModel({
    super.bids,
    super.symbol,
    super.asks,
  });

  Map<String, dynamic> toJson() {
    return {
      "symbol": symbol,
      "bids": bids,
      "asks": asks,
    };
  }

  factory OrderBookModel.fromJson(Map jsonMap) {
    return OrderBookModel(
      symbol: jsonMap["symbol"],
      asks: jsonMap["asks"],
      bids: jsonMap["bids"],
    );
  }

  factory OrderBookModel.empty(Map jsonMap) {
    return const OrderBookModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}



// {
//         "symbol": "ETHBTC",
//         "price": "0.02289000",
//         "24h_change": "0.881%"
//     },