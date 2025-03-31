import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {
  final String? symbol;
  final String? name;
  final List<String>? chains;

  const CoinEntity({
    required this.chains,
    required this.symbol,
    required this.name,
  });

  @override
  List<Object?> get props => [
        symbol,
        chains,
        name,
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