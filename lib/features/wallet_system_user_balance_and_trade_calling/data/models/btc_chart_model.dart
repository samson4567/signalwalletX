import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/btc_chart_model.dart';

class BtcDataChartModel extends BtcDataChartEntity {
  const BtcDataChartModel({
    String? name, // Nullable name
    required double price,
    required double percentIncrease,
    required List<ChartData> chart,
    required String symbol,
  }) : super(
          name: name,
          price: price,
          percentIncrease: percentIncrease,
          chart: chart,
          symbol: symbol,
        );

  factory BtcDataChartModel.fromJson(Map<String, dynamic> json) {
    return BtcDataChartModel(
      name: json['name'], // 'name' can be null
      price: json['price']?.toDouble() ?? 0.0,
      percentIncrease: json['percent_increase']?.toDouble() ?? 0.0,
      chart: (json['chart'] as List<dynamic>)
          .map((item) => ChartData(
                time: item['time'] ?? '',
                price: item['price']?.toDouble() ?? 0.0,
              ))
          .toList(),
      symbol: json['symbol'] ??
          '', // Ensure 'symbol' is handled (add it to the JSON if not already present)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name, // Nullable name
      'price': price,
      'percent_increase': percentIncrease,
      'chart': chart
          .map((item) => {
                'time': item.time,
                'price': item.price,
              })
          .toList(),
      'symbol': symbol, // Ensure symbol is included in JSON
    };
  }
}
