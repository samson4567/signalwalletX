import 'package:equatable/equatable.dart';

class OrderBookEntity extends Equatable {
  final String? symbol;
  final Map? bids;
  final Map? asks;

  const OrderBookEntity({
    required this.bids,
    required this.symbol,
    required this.asks,
  });

  @override
  List<Object?> get props => [
        symbol,
        bids,
        asks,
      ];
}



// {
//         "symbol": "ETHBTC",
//         "price": "0.02289000",
//         "24h_change": "0.881%"
//     },