import 'package:equatable/equatable.dart';

class ConversionEntity extends Equatable {
  final String? symbol;
  final String? createdAt;
  final String? rate;

  final String? fromCurrency;
  final String? fromAmount;
  final String? toAmount;

  final String? toCurrency;

  const ConversionEntity({
    required this.fromCurrency,
    required this.symbol,
    required this.toCurrency,
    required this.fromAmount,
    required this.toAmount,
    required this.rate,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        fromCurrency,
        symbol,
        toCurrency,
        fromAmount,
        toAmount,
        rate,
        createdAt,
      ];
}



// {
//             "from_currency": "BTC",
//             "to_currency": "USDT",
//             "from_amount": "0.05000000",
//             "to_amount": "4123.92050000",
//             "rate": "82478.41000000",
//             "created_at": "2025-03-18T12:54:52.000000Z"
//         },

// {
//     "message": "Conversion successful.",
//     "from_currency": "BTC",
//     "to_currency": "USDT",
//     "amount_converted": 0.05,
//     "converted_amount": 4123.9205,
//     "rate": "82478.41000000"
// }