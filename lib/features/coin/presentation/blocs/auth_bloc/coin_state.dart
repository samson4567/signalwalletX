import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';

sealed class CoinState extends Equatable {
  const CoinState();

  @override
  List<Object> get props => [];
}

// ignore: camel_case_types
final class coinInitial extends CoinState {
  const coinInitial();
}

///// GetBTCDetail
final class GetBTCDetailLoadingState extends CoinState {
  const GetBTCDetailLoadingState();
}

final class GetBTCDetailSuccessState extends CoinState {
  final CoinModel coinModel;

  const GetBTCDetailSuccessState({required this.coinModel});

  @override
  List<Object> get props => [coinModel];
}

final class GetBTCDetailErrorState extends CoinState {
  final String errorMessage;

  const GetBTCDetailErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// GetBTCDetail ended .....

///// GetTopCoin
final class GetTopCoinLoadingState extends CoinState {
  const GetTopCoinLoadingState();
}

final class GetTopCoinSuccessState extends CoinState {
  final List<CoinModel> listOfCoinModel;

  const GetTopCoinSuccessState({required this.listOfCoinModel});

  @override
  List<Object> get props => [listOfCoinModel];
}

final class GetTopCoinErrorState extends CoinState {
  final String errorMessage;

  const GetTopCoinErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// GetTopCoin ended .....

///// GetMarketCoins
final class GetMarketCoinsLoadingState extends CoinState {
  const GetMarketCoinsLoadingState();
}

final class GetMarketCoinsSuccessState extends CoinState {
  final List<CoinModel> listOfCoinModel;

  const GetMarketCoinsSuccessState({required this.listOfCoinModel});

  @override
  List<Object> get props => [listOfCoinModel];
}

final class GetMarketCoinsErrorState extends CoinState {
  final String errorMessage;

  const GetMarketCoinsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// GetMarketCoins ended .....

///// FetchCoinPrice
final class FetchCoinPriceLoadingState extends CoinState {
  const FetchCoinPriceLoadingState();
}

final class FetchCoinPriceSuccessState extends CoinState {
  final String? price;

  const FetchCoinPriceSuccessState({required this.price});

  @override
  List<Object> get props => [price ?? ""];
}

final class FetchCoinPriceErrorState extends CoinState {
  final String errorMessage;

  const FetchCoinPriceErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// FetchCoinPrice ended .....


// FetchCoinPrice