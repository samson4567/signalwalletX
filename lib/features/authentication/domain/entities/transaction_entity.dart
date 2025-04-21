import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final int id;
  final int userId;
  final String? tid;
  final String? title;
  final int? purchaseDuration;
  final String? orderTime;
  final String? followCondition;
  final bool createdByAdmin;
  final String orderId;
  final String symbol;
  final String side;
  final String type;
  final String price;
  final String quantity;
  final String status;
  final String pnl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TransactionEntity({
    required this.id,
    required this.userId,
    this.tid,
    this.title,
    this.purchaseDuration,
    this.orderTime,
    this.followCondition,
    required this.createdByAdmin,
    required this.orderId,
    required this.symbol,
    required this.side,
    required this.type,
    required this.price,
    required this.quantity,
    required this.status,
    required this.pnl,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        tid,
        title,
        purchaseDuration,
        orderTime,
        followCondition,
        createdByAdmin,
        orderId,
        symbol,
        side,
        type,
        price,
        quantity,
        status,
        pnl,
        createdAt,
        updatedAt,
      ];
}
