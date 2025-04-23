import 'package:signalwavex/features/authentication/domain/entities/recent_transaction_entity.dart';

class RecentTransactionModel extends RecentTransactionEntity {
  const RecentTransactionModel({
    required super.id,
    required super.userId,
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
    super.iconUrl, // Added as optional
  });

  factory RecentTransactionModel.fromJson(Map<String, dynamic> json) {
    return RecentTransactionModel(
      id: json['id'],
      userId: json['user_id'],
      orderId: json['order_id'],
      symbol: json['symbol'],
      side: json['side'],
      type: json['type'],
      price: json['price'],
      quantity: json['quantity'],
      status: json['status'],
      pnl: json['pnl'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      iconUrl: json['icon_url'], // Added from JSON
    );
  }

  static List<RecentTransactionModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => RecentTransactionModel.fromJson(json))
        .toList();
  }
}
