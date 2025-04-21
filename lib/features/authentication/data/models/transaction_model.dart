import 'package:signalwavex/features/authentication/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.userId,
    super.tid,
    super.title,
    super.purchaseDuration,
    super.orderTime,
    super.followCondition,
    required super.createdByAdmin,
    required super.orderId,
    required super.symbol,
    required super.side,
    required super.type,
    required super.price,
    required super.quantity,
    required super.status,
    required super.pnl,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      userId: json['user_id'],
      tid: json['tid'],
      title: json['title'],
      purchaseDuration: json['purchase_duration'],
      orderTime: json['order_time'],
      followCondition: json['follow_condition'],
      createdByAdmin: json['created_by_admin'] == 1,
      orderId: json['order_id'],
      symbol: json['symbol'],
      side: json['side'],
      type: json['type'],
      price: json['price'],
      quantity: json['quantity'],
      status: json['status'],
      pnl: json['pnl'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'tid': tid,
      'title': title,
      'purchase_duration': purchaseDuration,
      'order_time': orderTime,
      'follow_condition': followCondition,
      'created_by_admin': createdByAdmin ? 1 : 0,
      'order_id': orderId,
      'symbol': symbol,
      'side': side,
      'type': type,
      'price': price,
      'quantity': quantity,
      'status': status,
      'pnl': pnl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
