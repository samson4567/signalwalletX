import 'package:signalwavex/features/trading_system/domain/entities/live_market_price_entity.dart';

class LiveMarketPriceModel extends LiveMarketPriceEntity {
  const LiveMarketPriceModel({
    required super.symbol,
    required super.priceChange,
    required super.priceChangePercent,
    required super.weightedAvgPrice,
    required super.prevClosePrice,
    required super.lastPrice,
    required super.lastQty,
    required super.bidPrice,
    required super.bidQty,
    required super.askPrice,
    required super.askQty,
    required super.openPrice,
    required super.highPrice,
    required super.lowPrice,
    required super.volume,
    required super.quoteVolume,
    required super.openTime,
    required super.closeTime,
    required super.firstId,
    required super.lastId,
    required super.count,
  });

  factory LiveMarketPriceModel.fromJson(Map<String, dynamic> json) {
    return LiveMarketPriceModel(
      symbol: json['symbol'],
      priceChange: json['priceChange'],
      priceChangePercent: json['priceChangePercent'],
      weightedAvgPrice: json['weightedAvgPrice'],
      prevClosePrice: json['prevClosePrice'],
      lastPrice: json['lastPrice'],
      lastQty: json['lastQty'],
      bidPrice: json['bidPrice'],
      bidQty: json['bidQty'],
      askPrice: json['askPrice'],
      askQty: json['askQty'],
      openPrice: json['openPrice'],
      highPrice: json['highPrice'],
      lowPrice: json['lowPrice'],
      volume: json['volume'],
      quoteVolume: json['quoteVolume'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      firstId: json['firstId'],
      lastId: json['lastId'],
      count: json['count'],
    );
  }
}
