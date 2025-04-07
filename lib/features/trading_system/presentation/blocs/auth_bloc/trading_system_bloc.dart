import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/core/app_variables.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_event.dart';
import 'package:signalwavex/features/trading_system/domain/repositories/trading_system_repository.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_event.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_state.dart';

class TradingSystemBloc extends Bloc<TradingSystemEvent, TradingSystemState> {
  final TradingSystemRepository tradingSystemRepository;
  AppBloc appBloc;

  TradingSystemBloc(
      {required this.tradingSystemRepository, required this.appBloc})
      : super(const TradingSystemInitial()) {
    on<FetchOrderBookEvent>(_onFetchOrderBookEvent);
    on<PlaceABuyOrSellOrderRequestEvent>(_onPlaceABuyOrSellOrderRequestEvent);

    on<ConversionEvent>(_onConversionEvent);
    on<GetConversionEvent>(_onGetConversionEvent);
    on<GetCoinListEvent>(_onGetCoinListEvent);
    on<GetExchangeRateEvent>(_onGetExchangeRateEvent);
  }

  Future<void> _onFetchOrderBookEvent(
      FetchOrderBookEvent event, Emitter<TradingSystemState> emit) async {
    emit(const FetchOrderBookLoadingState());
    final result =
        await tradingSystemRepository.fetchOrderBook(symbol: event.symbol);
    result.fold(
      (error) => emit(FetchOrderBookErrorState(errorMessage: error.message)),
      (orderBookEntity) =>
          emit(FetchOrderBookSuccessState(orderBookEntity: orderBookEntity)),
    );
  }

  Future<void> _onPlaceABuyOrSellOrderRequestEvent(
      PlaceABuyOrSellOrderRequestEvent event,
      Emitter<TradingSystemState> emit) async {
    emit(const PlaceABuyOrSellOrderRequestLoadingState());
    final result = await tradingSystemRepository.placeABuyOrSellOrderRequest(
        placeABuyOrSellOrderRequestEntity:
            event.placeABuyOrSellOrderRequestEntity);
    result.fold(
      (error) => emit(
          PlaceABuyOrSellOrderRequestErrorState(errorMessage: error.message)),
      (message) =>
          emit(PlaceABuyOrSellOrderRequestSuccessState(message: message)),
    );
  }

  Future<void> _onConversionEvent(
      ConversionEvent event, Emitter<TradingSystemState> emit) async {
    emit(const ConversionLoadingState());
    final result = await tradingSystemRepository.convert(
        conversionEntity: event.conversionEntity);
    result.fold(
      (error) => emit(ConversionErrorState(errorMessage: error.message)),
      (conversionEntity) =>
          emit(ConversionSuccessState(conversionEntity: conversionEntity)),
    );
  }

  Future<void> _onGetConversionEvent(
      GetConversionEvent event, Emitter<TradingSystemState> emit) async {
    emit(const GetConversionLoadingState());
    final result = await tradingSystemRepository.getConversions();
    result.fold(
      (error) => emit(GetConversionErrorState(errorMessage: error.message)),
      (listOfConversionEntity) => emit(GetConversionSuccessState(
          listOfConversionEntity: listOfConversionEntity)),
    );
  }

  Future<void> _onGetCoinListEvent(
      GetCoinListEvent event, Emitter<TradingSystemState> emit) async {
    emit(const GetCoinListLoadingState());
    final result = await tradingSystemRepository.getCoins();
    result.fold(
      (error) => emit(GetCoinListErrorState(errorMessage: error.message)),
      (listOfCoinEntity) {
        appBloc.add(StoreCoinsEvent(listOfCoinEntity: listOfCoinEntity));
        listOfCoinEntityG = listOfCoinEntity;
        emit(GetCoinListSuccessState(listOfCoinEntity: listOfCoinEntity));
      },
    );
  }

  Future<void> _onGetExchangeRateEvent(
      GetExchangeRateEvent event, Emitter<TradingSystemState> emit) async {
    emit(const GetExchangeRateLoadingState());
    final result = await tradingSystemRepository.getExchangeRate(
        from: event.from, to: event.to);
    result.fold(
      (error) => emit(GetExchangeRateErrorState(errorMessage: error.message)),
      (rate) {
        emit(GetExchangeRateSuccessState(rate: rate));
      },
    );
  }
}
