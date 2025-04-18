import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final double? id;

  final String? title;
  final String? tid;
  final String? userID;

  final String? tradingPair;
  final String? purchaseDuration;
  final String? orderTime;
  final String? followCondition;
  final int? createdByAdmin;
  final String? symbol;
  final String? orderID;
  final String? side;
  final String? type;
  final String? price;
  final String? quantity;
  final String? status;
  final String? pnl;
  final String? createdAt;
  final String? updatedAt;
  final String? timePeriod;
  final String? tradePeriod;

  // final String? orderDirection;
  // final double? purchaseDuration;
  // final String? orderTime;
  // final String? followCondition;
  // final String? status;
  // final String? adminID;
  const OrderEntity({
    required this.createdAt,
    required this.timePeriod,
    required this.tradePeriod,
    required this.updatedAt,
    required this.tid,
    required this.createdByAdmin,
    required this.symbol,
    required this.orderID,
    required this.side,
    required this.type,
    required this.price,
    required this.quantity,
    required this.pnl,
    required this.tradingPair,
    required this.id,
    required this.title,
    required this.purchaseDuration,
    required this.orderTime,
    required this.followCondition,
    required this.status,
    required this.userID,
  });

  @override
  List<Object?> get props => [
        tid,
        createdByAdmin,
        symbol,
        orderID,
        side,
        type,
        price,
        quantity,
        pnl,
        tradingPair,
        id,
        title,
        purchaseDuration,
        orderTime,
        followCondition,
        status,
        userID,
      ];
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