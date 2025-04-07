import 'package:equatable/equatable.dart';

class BtcDataChartEntity extends Equatable {
  final String? name; // Nullable name
  final double price;
  final double percentIncrease;
  final List<ChartData> chart;
  final String symbol;

  const BtcDataChartEntity({
    this.name, // Nullable name
    required this.price,
    required this.percentIncrease,
    required this.chart,
    required this.symbol,
  });

  @override
  List<Object?> get props => [
        name,
        price,
        percentIncrease,
        chart,
        symbol
      ]; // Use nullable types in props
}

class ChartData extends Equatable {
  final String time;
  final double price;

  const ChartData({
    required this.time,
    required this.price,
  });

  @override
  List<Object> get props => [time, price];
}
