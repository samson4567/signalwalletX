import 'package:equatable/equatable.dart';

class HistoricalOrderEntity extends Equatable {
  final String? status;
  final String? profitLoss;
  final String? tradePeriod;
  final String? product;
  final String? direction;
  final String? timePeriod;
  final String? amount;
  final String? openPositionTime;
  final String? openPrice;
  final String? settlementPrice;
  final String? turnover;
  final String? rateOfReturn;
  const HistoricalOrderEntity({
    required this.openPositionTime,
    required this.timePeriod,
    required this.tradePeriod,
    required this.openPrice,
    required this.direction,
    required this.amount,
    required this.profitLoss,
    required this.turnover,
    required this.product,
    required this.status,
    required this.settlementPrice,
    required this.rateOfReturn,
  });

  @override
  List<Object?> get props => [
        openPrice,
        direction,
        amount,
        profitLoss,
        turnover,
        product,
        status,
        settlementPrice,
      ];
}

//  {
//             "product": "BTC",
//             "status": "FILLED",
//             "direction": "CALL",
//             "time_period": "5",
//             "amount": "0.00000000",
//             "open_position_time": null,
//             "open_price": "102000.00000000",
//             "settlement_price": "102500.00000000",
//             "turnover": "0.00000000",
//             "trade_period": "10:00",
//             "profit_loss": 0,
//             "rate_of_return": "30"
//         },