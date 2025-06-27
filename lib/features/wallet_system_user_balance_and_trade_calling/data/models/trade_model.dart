import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/order_entity.dart';
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
    super.rawDetail,
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
        status: jsonMap["status"],
        rawDetail: jsonMap);
  }
  factory TradeModel.fromEntity(TradeEntity tradeEntity) {
    return TradeModel(
        id: tradeEntity.id,
        title: tradeEntity.title,
        tradingPair: tradeEntity.tradingPair,
        orderDirection: tradeEntity.orderDirection,
        purchaseDuration: tradeEntity.purchaseDuration,
        orderTime: tradeEntity.orderTime,
        followCondition: tradeEntity.followCondition,
        status: tradeEntity.status,
        rawDetail: tradeEntity.rawDetail);
  }
  factory TradeModel.fromOrderEntity(OrderEntity orderEntity) {
    return TradeModel(
        id: orderEntity.id,
        title: orderEntity.title,
        tradingPair: orderEntity.tradingPair,
        purchaseDuration:
            double.tryParse(orderEntity.purchaseDuration.toString()),
        orderTime: orderEntity.orderTime,
        followCondition: orderEntity.followCondition,
        status: orderEntity.status);
  }

  factory TradeModel.empty(Map jsonMap) {
    return const TradeModel();
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
