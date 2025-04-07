// import 'package:signalwavex/features/trading_system/domain/entities/%20binance_market_entity.dart';

// class BinanceTicker24hModel extends BinanceTicker24hEntity {
//   const BinanceTicker24hModel({
//     required super.symbol,
//     required super.priceChange,
//     required super.priceChangePercent,
//     required super.weightedAvgPrice,
//     required super.lastPrice,
//     required super.highPrice,
//     required super.lowPrice,
//     required super.volume,
//     required super.quoteVolume,
//   });

//   factory BinanceTicker24hModel.fromJson(Map<String, dynamic> json) {
//     return BinanceTicker24hModel(
//       symbol: json['symbol'],
//       priceChange: double.parse(json['priceChange']),
//       priceChangePercent: double.parse(json['priceChangePercent']),
//       weightedAvgPrice: double.parse(json['weightedAvgPrice']),
//       lastPrice: double.parse(json['lastPrice']),
//       highPrice: double.parse(json['highPrice']),
//       lowPrice: double.parse(json['lowPrice']),
//       volume: double.parse(json['volume']),
//       quoteVolume: double.parse(json['quoteVolume']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'symbol': symbol,
//       'priceChange': priceChange.toString(),
//       'priceChangePercent': priceChangePercent.toString(),
//       'weightedAvgPrice': weightedAvgPrice.toString(),
//       'lastPrice': lastPrice.toString(),
//       'highPrice': highPrice.toString(),
//       'lowPrice': lowPrice.toString(),
//       'volume': volume.toString(),
//       'quoteVolume': quoteVolume.toString(),
//     };
//   }
// }
