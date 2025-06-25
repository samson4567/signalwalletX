import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class TradeEntity extends Equatable {
  final int? id;
  final String? title;
  final String? tradingPair;
  final String? orderDirection;
  final double? purchaseDuration;
  final String? orderTime;
  final String? followCondition;
  final String? status;
  final String? adminID;
  final Map? rawDetail;

  const TradeEntity({
    required this.orderDirection,
    required this.tradingPair,
    required this.id,
    required this.title,
    required this.purchaseDuration,
    required this.orderTime,
    required this.followCondition,
    required this.status,
    required this.adminID,
    required this.rawDetail,
  });

  @override
  List<Object?> get props => [
        orderDirection,
        tradingPair,
        id,
        title,
        purchaseDuration,
        orderTime,
        followCondition,
        status,
      ];
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
