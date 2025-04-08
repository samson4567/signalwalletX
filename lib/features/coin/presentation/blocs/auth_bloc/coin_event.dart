import 'package:equatable/equatable.dart';

abstract class CoinEvent extends Equatable {
  const CoinEvent();

  @override
  List<Object> get props => [];
}

final class GetBTCDetailEvent extends CoinEvent {
  const GetBTCDetailEvent();

  @override
  List<Object> get props => [];
}

// GetTopCoin
final class GetTopCoinEvent extends CoinEvent {
  const GetTopCoinEvent();

  @override
  List<Object> get props => [];
}

// GetMarketCoins
final class GetMarketCoinsEvent extends CoinEvent {
  const GetMarketCoinsEvent();

  @override
  List<Object> get props => [];
}
