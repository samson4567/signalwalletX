import 'package:signalwavex/features/authentication/domain/entities/recent_transaction_entity.dart';

class RecentTransactionModel extends RecentTransactionEntity {
  const RecentTransactionModel({
    required int id,
    required int userId,
    required String orderId,
    required String symbol,
    required String side,
    required String type,
    required String price,
    required String quantity,
    required String status,
    required String pnl,
    required String createdAt,
    required String updatedAt,
    String? iconUrl, // Added as optional
  }) : super(
          id: id,
          userId: userId,
          orderId: orderId,
          symbol: symbol,
          side: side,
          type: type,
          price: price,
          quantity: quantity,
          status: status,
          pnl: pnl,
          createdAt: createdAt,
          updatedAt: updatedAt,
          iconUrl: iconUrl, // Passed to super
        );

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
