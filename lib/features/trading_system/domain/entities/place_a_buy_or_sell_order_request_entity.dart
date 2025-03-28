import 'package:equatable/equatable.dart';

class PlaceABuyOrSellOrderRequestEntity extends Equatable {
  final String? symbol;
  final String? side;
  final String? type;
  final double? quantity;
  final double? price;
  final String? timeInForce;

  const PlaceABuyOrSellOrderRequestEntity({
    required this.side,
    required this.symbol,
    required this.type,
    required this.quantity,
    required this.price,
    required this.timeInForce,
  });

  @override
  List<Object?> get props => [
        symbol,
        side,
        type,
      ];
}



// {
//     "symbol": "BTCUSDT",
//     "side": "SELL",
//     "type": "LIMIT",
//     "quantity": 0.01,
//     "price": 46000,
//     "time_in_force": "GTC"
// }