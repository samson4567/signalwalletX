import 'package:signalwavex/features/trading_system/domain/entities/conversion_entity.dart';

// ConversionEntity

class ConversionModel extends ConversionEntity {
  const ConversionModel({
    super.fromCurrency,
    super.symbol,
    super.toCurrency,
    super.fromAmount,
    super.toAmount,
    super.rate,
    super.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "from_currency": fromCurrency,
      "to_currency": toCurrency,
      "from_amount": fromAmount,
      "to_amount": toAmount,
      "rate": rate,
      "created_at": createdAt,
    };
  }

  Map<String, dynamic> toConvertRequestMap() {
    return {
      "from_currency": fromCurrency,
      "to_currency": toCurrency,
      "amount": double.tryParse(fromAmount ?? ""),
    };
  }

  factory ConversionModel.fromConvertResponseMap(Map jsonMap) {
    return ConversionModel(
      fromCurrency: jsonMap["from_currency"],
      toCurrency: jsonMap["to_currency"],
      fromAmount: jsonMap["from_amount"],
      toAmount: jsonMap["to_amount"],
      rate: jsonMap["rate"],
      createdAt: jsonMap["created_at"],
    );
  }

  factory ConversionModel.fromJson(Map jsonMap) {
    return ConversionModel(
      fromCurrency: jsonMap["from_currency"],
      toCurrency: jsonMap["to_currency"],
      fromAmount: jsonMap["amount_converted"],
      toAmount: jsonMap["converted_amount"],
      rate: jsonMap["rate"],
    );
  }

  factory ConversionModel.empty(Map jsonMap) {
    return ConversionModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
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