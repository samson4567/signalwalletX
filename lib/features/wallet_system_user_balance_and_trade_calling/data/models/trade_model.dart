import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_entity.dart';

// TradeEntity

class TradeModel extends TradeEntity {
  const TradeModel({
    super.orderDirection,
    super.tradingPair,
    super.id,
    super.title,
    super.purchaseDuration,
    super.orderTime,
    super.followCondition,
    super.status,
    super.adminID,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "trading_pair": tradingPair,
      "order_direction": orderDirection,
      "purchase_duration": purchaseDuration,
      "order_time": orderTime,
      "follow_condition": followCondition,
      "status": status
    };
  }

  Map<String, dynamic> toSuperAdmintradeCallResponsetMap() {
    return {
      "id": id,
      "title": title,
      "trading_pair": tradingPair,
      "order_direction": orderDirection,
      "purchase_duration": purchaseDuration,
      "order_time": orderTime,
      "follow_condition": followCondition,
      "status": status
    };
  }

  Map<String, dynamic> toSuperAdmintradeCallRequestMap() {
    return {
      "title": title,
      "trading_pair": tradingPair,
      "order_direction": orderDirection,
      "purchase_duration": purchaseDuration,
      "order_time": orderTime,
      "follow_condition": followCondition,
    };
  }

  factory TradeModel.fromJson(Map jsonMap) {
    return TradeModel(
        id: jsonMap["id"],
        title: jsonMap["title"],
        tradingPair: jsonMap["trading_pair"],
        orderDirection: jsonMap["order_direction"],
        purchaseDuration: jsonMap["purchase_duration"],
        orderTime: jsonMap["order_time"],
        followCondition: jsonMap["follow_condition"],
        status: jsonMap["status"]);
  }

  factory TradeModel.empty(Map jsonMap) {
    return TradeModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}


// {
//             "id": 1,
//             "title": "Bitcoin Long Position",
//             "trading_pair": "USDT/BTC",
//             "order_direction": "CALL",
//             "purchase_duration": 80,
//             "order_time": "2025-03-05 12:30:00",
//             "follow_condition": "Minimum",
//             "status": "active"
//         },
