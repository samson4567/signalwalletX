import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/trading_system/domain/entities/coin_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/conversion_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/order_book_entity.dart';
import 'package:signalwavex/features/trading_system/domain/entities/tradeorder_entity.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/order_entity.dart';

sealed class TradingSystemState extends Equatable {
  const TradingSystemState();

  @override
  List<Object> get props => [];
}

final class TradingSystemInitial extends TradingSystemState {
  const TradingSystemInitial();
}

// FetchOrderBook

/// FetchOrderBook
final class FetchOrderBookLoadingState extends TradingSystemState {
  const FetchOrderBookLoadingState();
}

final class FetchOrderBookSuccessState extends TradingSystemState {
  final OrderBookEntity orderBookEntity;

  const FetchOrderBookSuccessState({required this.orderBookEntity});

  @override
  List<Object> get props => [orderBookEntity];
}

final class FetchOrderBookErrorState extends TradingSystemState {
  final String errorMessage;

  const FetchOrderBookErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// FetchOrderBook ended .....

///// PlaceABuyOrSellOrderRequest
final class PlaceABuyOrSellOrderRequestLoadingState extends TradingSystemState {
  const PlaceABuyOrSellOrderRequestLoadingState();
}

final class PlaceABuyOrSellOrderRequestSuccessState extends TradingSystemState {
  final String message;

  const PlaceABuyOrSellOrderRequestSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class PlaceABuyOrSellOrderRequestErrorState extends TradingSystemState {
  final String errorMessage;

  const PlaceABuyOrSellOrderRequestErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// PlaceABuyOrSellOrderRequest ended .....

///// Conversion
final class ConversionLoadingState extends TradingSystemState {
  const ConversionLoadingState();
}

final class ConversionSuccessState extends TradingSystemState {
  final ConversionEntity conversionEntity;

  const ConversionSuccessState({required this.conversionEntity});

  @override
  List<Object> get props => [conversionEntity];
}

final class ConversionErrorState extends TradingSystemState {
  final String errorMessage;

  const ConversionErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// Conversion ended .....

///// GetConversion
final class GetConversionLoadingState extends TradingSystemState {
  const GetConversionLoadingState();
}

final class GetConversionSuccessState extends TradingSystemState {
  final List<ConversionEntity> listOfConversionEntity;

  const GetConversionSuccessState({required this.listOfConversionEntity});

  @override
  List<Object> get props => [listOfConversionEntity];
}

final class GetConversionErrorState extends TradingSystemState {
  final String errorMessage;

  const GetConversionErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// GetConversion ended .....

///// GetCoinList
final class GetCoinListLoadingState extends TradingSystemState {
  const GetCoinListLoadingState();
}

final class GetCoinListSuccessState extends TradingSystemState {
  final List<CoinEntity> listOfCoinEntity;

  const GetCoinListSuccessState({required this.listOfCoinEntity});

  @override
  List<Object> get props => [listOfCoinEntity];
}

final class GetCoinListErrorState extends TradingSystemState {
  final String errorMessage;

  const GetCoinListErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// GetCoinList ended .....

///// GetExchangeRate
final class GetExchangeRateLoadingState extends TradingSystemState {
  const GetExchangeRateLoadingState();
}

final class GetExchangeRateSuccessState extends TradingSystemState {
  final String rate;

  const GetExchangeRateSuccessState({required this.rate});

  @override
  List<Object> get props => [rate];
}

final class GetExchangeRateErrorState extends TradingSystemState {
  final String errorMessage;

  const GetExchangeRateErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class TraderOrderFollowedLoading extends TradingSystemState {}

class TraderOrderFollowedLoaded extends TradingSystemState {
  final TraderOrderFollowedEntity traderOrderFollowed;

  const TraderOrderFollowedLoaded(this.traderOrderFollowed);

  @override
  List<Object> get props => [traderOrderFollowed];
}

class TraderOrderFollowedError extends TradingSystemState {
  final String message;

  const TraderOrderFollowedError(this.message);

  @override
  List<Object> get props => [message];
}

///// FetchActiveTrade
final class FetchActiveTradeLoadingState extends TradingSystemState {
  const FetchActiveTradeLoadingState();
}

final class FetchActiveTradeSuccessState extends TradingSystemState {
  final OrderEntity orderEntity;

  const FetchActiveTradeSuccessState({required this.orderEntity});

  @override
  List<Object> get props => [orderEntity];
}

final class FetchActiveTradeErrorState extends TradingSystemState {
  final String errorMessage;

  const FetchActiveTradeErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// FetchActiveTrade ended .....


