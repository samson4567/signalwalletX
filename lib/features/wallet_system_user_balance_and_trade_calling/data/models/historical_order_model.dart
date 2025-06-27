import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/historical_order_entity.dart';

// HistoricalOrderEntity
class HistoricalOrderModel extends HistoricalOrderEntity {
  const HistoricalOrderModel({
    super.openPositionTime,
    super.timePeriod,
    super.tradePeriod,
    super.openPrice,
    super.direction,
    super.amount,
    super.profitLoss,
    super.turnover,
    super.product,
    super.status,
    super.settlementPrice,
    super.rateOfReturn,
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

  Map<String, dynamic> toJson() {
    return {
      "direction": direction,
      "profit_loss": profitLoss,
      "amount": amount,
      "open_position_time": openPositionTime,
      "open_price": openPrice,
      "product": product,
      "rate_of_return": rateOfReturn,
      "settlement_price": settlementPrice,
      "status": status,
      "time_period": timePeriod,
      "trade_period": tradePeriod,
      "turnover": turnover,
    };
  }

  factory HistoricalOrderModel.fromJson(Map jsonMap) {
    print("dbfjjfbsjdfhbsjhfsbd-${jsonMap}");
    return HistoricalOrderModel(
      direction: jsonMap["direction"],
      profitLoss: (jsonMap["profit_loss"] == null)
          ? null
          : jsonMap["profit_loss"].toString(),
      amount: jsonMap["amount"],
      openPositionTime: jsonMap["open_position_time"],
      openPrice: jsonMap["open_price"],
      product: jsonMap["product"],
      rateOfReturn: jsonMap["rate_of_return"],
      settlementPrice: jsonMap["settlement_price"],
      status: jsonMap["status"],
      timePeriod: jsonMap["time_period"],
      tradePeriod: jsonMap["trade_period"],
      turnover: jsonMap["turnover"],
    );
  }
  factory HistoricalOrderModel.fromEntity(
      HistoricalOrderEntity historicalOrderEntity) {
    return HistoricalOrderModel(
      profitLoss: historicalOrderEntity.profitLoss,
      amount: historicalOrderEntity.amount,
      openPositionTime: historicalOrderEntity.openPositionTime,
      openPrice: historicalOrderEntity.openPrice,
      direction: historicalOrderEntity.direction,
      product: historicalOrderEntity.product,
      rateOfReturn: historicalOrderEntity.rateOfReturn,
      settlementPrice: historicalOrderEntity.settlementPrice,
      status: historicalOrderEntity.status,
      timePeriod: historicalOrderEntity.timePeriod,
      tradePeriod: historicalOrderEntity.tradePeriod,
      turnover: historicalOrderEntity.turnover,
    );
  }

  factory HistoricalOrderModel.empty(Map jsonMap) {
    return const HistoricalOrderModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
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