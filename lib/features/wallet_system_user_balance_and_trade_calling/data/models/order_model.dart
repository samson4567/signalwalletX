import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/order_entity.dart';

// OrderModel
class OrderModel extends OrderEntity {
  const OrderModel({
    super.createdAt,
    super.updatedAt,
    super.tid,
    super.createdByAdmin,
    super.symbol,
    super.orderID,
    super.side,
    super.type,
    super.price,
    super.quantity,
    super.pnl,
    super.tradingPair,
    super.id,
    super.title,
    super.purchaseDuration,
    super.orderTime,
    super.followCondition,
    super.status,
    super.userID,
    super.timePeriod,
    super.tradePeriod,
    super.rateOfReturn,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userID,
      "tid": tid,
      "title": title,
      "purchase_duration": purchaseDuration,
      "order_time": orderTime,
      "follow_condition": followCondition,
      "created_by_admin": createdByAdmin,
      "order_id": orderID,
      "symbol": symbol,
      "side": side,
      "type": type,
      "price": price,
      "quantity": quantity,
      "status": status,
      "pnl": pnl,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "time_period": timePeriod,
      "trade_period": tradePeriod,
      "rate_of_return": rateOfReturn
    };
  }

  factory OrderModel.fromEntity(OrderEntity orderEntity) {
    return OrderModel(
        id: orderEntity.id,
        userID: orderEntity.userID,
        tid: orderEntity.tid,
        title: orderEntity.title,
        purchaseDuration: orderEntity.purchaseDuration,
        orderTime: orderEntity.orderTime,
        followCondition: orderEntity.followCondition,
        createdByAdmin: orderEntity.createdByAdmin,
        orderID: orderEntity.orderID,
        symbol: orderEntity.symbol,
        side: orderEntity.side,
        type: orderEntity.type,
        price: orderEntity.price,
        quantity: orderEntity.quantity,
        status: orderEntity.status,
        pnl: orderEntity.pnl,
        createdAt: orderEntity.createdAt,
        updatedAt: orderEntity.updatedAt,
        rateOfReturn: orderEntity.rateOfReturn);
  }
  factory OrderModel.fromJson(Map jsonMap) {
    var t = {};
    return OrderModel(
      id: jsonMap["id"],
      userID: jsonMap["user_id"]?.toString(),
      tid: jsonMap["tid"],
      title: jsonMap["title"],
      purchaseDuration: jsonMap["purchase_duration"],
      orderTime: jsonMap["order_time"],
      followCondition: jsonMap["follow_condition"],
      createdByAdmin: jsonMap["created_by_admin"],
      orderID: jsonMap["order_id"],
      rateOfReturn: jsonMap["rate_of_return"],
      symbol: jsonMap["symbol"],
      side: jsonMap["side"],
      type: jsonMap["type"],
      price: jsonMap["price"]?.toString(),
      quantity: jsonMap["quantity"]?.toString(),
      status: jsonMap["status"],
      pnl: jsonMap["pnl"],
      createdAt: jsonMap["created_at"],
      updatedAt: jsonMap["updated_at"],
    );
  }

  factory OrderModel.empty(Map jsonMap) {
    return OrderModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}

// {
//             "id": 8,
//             "user_id": 11,
//             "tid": null,
//             "title": null,
//             "purchase_duration": null,
//             "order_time": null,
//             "follow_condition": null,
//             "created_by_admin": 0,
//             "order_id": "ORD67F13D5AED649",
//             "symbol": "BTCUSDT",
//             "side": "SELL",
//             "type": "MARKET",
//             "price": "16135.45000000",
//             "quantity": "3.74760000",
//             "status": "FILLED",
//             "pnl": "-17.00000000",
//             "created_at": "2025-03-30T13:25:30.000000Z",
//             "updated_at": "2025-04-05T13:25:30.000000Z"
//         },