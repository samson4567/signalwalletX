import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/conversion_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/place_a_buy_or_sell_order_request_entity.dart';

abstract class TradingSystemEvent extends Equatable {
  const TradingSystemEvent();

  @override
  List<Object> get props => [];
}

// FetchLiveMarketPrices
final class FetchLiveMarketPricesEvent extends TradingSystemEvent {
  const FetchLiveMarketPricesEvent();

  @override
  List<Object> get props => [];
}

final class FetchOrderBookEvent extends TradingSystemEvent {
  final String symbol;
  const FetchOrderBookEvent(this.symbol);

  @override
  List<Object> get props => [];
}

final class PlaceABuyOrSellOrderRequestEvent extends TradingSystemEvent {
  final PlaceABuyOrSellOrderRequestEntity placeABuyOrSellOrderRequestEntity;
  const PlaceABuyOrSellOrderRequestEvent(
      this.placeABuyOrSellOrderRequestEntity);

  @override
  List<Object> get props => [];
}

final class ConversionEvent extends TradingSystemEvent {
  final ConversionEntity conversionEntity;
  const ConversionEvent(this.conversionEntity);

  @override
  List<Object> get props => [];
}

final class GetConversionEvent extends TradingSystemEvent {
  final ConversionEntity conversionEntity;
  const GetConversionEvent(this.conversionEntity);

  @override
  List<Object> get props => [];
}

final class GetCoinListEvent extends TradingSystemEvent {
  const GetCoinListEvent();

  @override
  List<Object> get props => [];
}

final class GetExchangeRateEvent extends TradingSystemEvent {
  final String to;
  final String from;

  const GetExchangeRateEvent(this.to, this.from);

  @override
  List<Object> get props => [];
}



// getExchangeRate