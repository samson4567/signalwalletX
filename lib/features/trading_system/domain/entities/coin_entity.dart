import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {
  final String? symbol;
  final String? name;
  final String? percentIncrease;

  final List<String>? chains;
  final String? imagePath;
  final String? price;

  const CoinEntity({
    this.percentIncrease,
    this.price,
    this.chains,
    required this.symbol,
    required this.name,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [
        symbol,
        chains,
        name,
        imagePath,
      ];
}


// {
//             "symbol": "USDT",
//             "name": "Tether",
//             "chains": [
//                 "BSC",
//                 "TRX",
//                 "ETH"
//             ]
//         },