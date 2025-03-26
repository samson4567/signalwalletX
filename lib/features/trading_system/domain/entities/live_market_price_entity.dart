import 'package:equatable/equatable.dart';

class LiveMarketPriceEntity extends Equatable {
  final String? symbol;
  final String? price;
  final String? twentyFourHourChange;

  const LiveMarketPriceEntity({
    required this.twentyFourHourChange,
    required this.symbol,
    required this.price,
  });

  @override
  List<Object?> get props => [
        twentyFourHourChange,
        symbol,
        price,
      ];
}



// {
//         "symbol": "ETHBTC",
//         "price": "0.02289000",
//         "24h_change": "0.881%"
//     },