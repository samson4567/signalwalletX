import 'package:equatable/equatable.dart';

class RecentTransactionEntity extends Equatable {
  final int id;
  final int userId;
  final String orderId;
  final String symbol;
  final String side;
  final String type;
  final String price;
  final String quantity;
  final String status;
  final String pnl;
  final String createdAt;
  final String updatedAt;
  final String? iconUrl;

  const RecentTransactionEntity({
    required this.id,
    required this.userId,
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
    this.iconUrl,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
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
        iconUrl,
      ];
}
