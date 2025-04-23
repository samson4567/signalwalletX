import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/coin/domain/repositories/coin_repository.dart';
import 'package:signalwavex/features/coin/presentation/blocs/auth_bloc/coin_event.dart';
import 'package:signalwavex/features/coin/presentation/blocs/auth_bloc/coin_state.dart';
import 'package:signalwavex/features/trading_system/data/models/coin_model.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final CoinRepository coinRepository;
  AppBloc appBloc;

  CoinBloc({required this.coinRepository, required this.appBloc})
      : super(const coinInitial()) {
    on<GetBTCDetailEvent>(_onGetBTCDetailEvent);
    on<GetTopCoinEvent>(_onGetTopCoinEvent);
    on<GetMarketCoinsEvent>(_onGetMarketCoinsEvent);
    on<FetchCoinPriceEvent>(_onFetchCoinPriceEvent);

    // FetchCoinPrice
  }

  Future<void> _onGetBTCDetailEvent(
      GetBTCDetailEvent event, Emitter<CoinState> emit) async {
    emit(const GetBTCDetailLoadingState());
    final result = await coinRepository.getBTCDetails();

    result.fold(
      (error) {
        emit(GetBTCDetailErrorState(errorMessage: error.message));
      },
      (coinEntity) {
        emit(GetBTCDetailSuccessState(
            coinModel: CoinModel.fromEntity(coinEntity)));
      },
    );
  }

  Future<void> _onGetTopCoinEvent(
      GetTopCoinEvent event, Emitter<CoinState> emit) async {
    emit(const GetTopCoinLoadingState());
    final result = await coinRepository.getTopCoins();
    result.fold(
      (error) => emit(GetTopCoinErrorState(errorMessage: error.message)),
      (listOfCoinModel) {
        emit(GetTopCoinSuccessState(
            listOfCoinModel: listOfCoinModel
                .map(
                  (e) => CoinModel.fromEntity(e),
                )
                .toList()));
      },
    );
  }

  Future<void> _onGetMarketCoinsEvent(
      GetMarketCoinsEvent event, Emitter<CoinState> emit) async {
    emit(const GetMarketCoinsLoadingState());
    final result = await coinRepository.getMarketCoins();
    result.fold(
      (error) => emit(GetMarketCoinsErrorState(errorMessage: error.message)),
      (listOfCoinModel) {
        emit(
          GetMarketCoinsSuccessState(
            listOfCoinModel: listOfCoinModel
                .map(
                  (e) => CoinModel.fromEntity(e),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Future<void> _onFetchCoinPriceEvent(
      FetchCoinPriceEvent event, Emitter<CoinState> emit) async {
    emit(const FetchCoinPriceLoadingState());
    final result = await coinRepository.fetchCoinPrice(
        tradingPairSymbol: event.tradingPairSymbol);
    result.fold(
      (error) => emit(FetchCoinPriceErrorState(errorMessage: error.message)),
      (price) {
        emit(
          FetchCoinPriceSuccessState(
            price: price,
          ),
        );
      },
    );
  }

  // _onFetchCoinPriceEvent
}
