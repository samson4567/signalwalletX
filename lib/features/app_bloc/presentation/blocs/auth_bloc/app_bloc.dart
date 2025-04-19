import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/features/app_bloc/domain/repositories/app_repository.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_event.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository appRepository;
  AppState? remeberedAppState;

  AppBloc({required this.appRepository}) : super(AppInitial()) {
    on<UserUpdateEvent>(_onUserUpdate);
    on<StorePNLEvent>(_onStorePNLEvent);
    on<StoreUserBalancesEvent>(_onStoreUserBalancesEvent);
    on<StoreCoinsEvent>(_onStoreCoinsEvent);

    // StoreUserBalancesEvent
  }

  Future<void> _onUserUpdate(
      UserUpdateEvent event, Emitter<AppState> emit) async {
    Map formerDetail = state.toMap();

    Map newDetail = UserUpdateSuccessState(
      user: event.updatedUserModel,
    ).toMap();

    newDetail.forEach(
      (key, value) {
        formerDetail[key] = value;
      },
    );

    emit(state.fromMap(formerDetail));
  }

  Future<void> _onStorePNLEvent(
      StorePNLEvent event, Emitter<AppState> emit) async {
    Map formerDetail = state.toMap();

    Map newDetail = StorePNLSuccessState(pnl: event.pnl).toMap();
    newDetail.forEach(
      (key, value) {
        formerDetail[key] = value;
      },
    );
    StorePNLSuccessState storePNLSuccessState =
        StorePNLSuccessState.fromAppState(state.fromMap(formerDetail));

    emit(state.fromMap(formerDetail));
  }

  Future<void> _onStoreCoinsEvent(
      StoreCoinsEvent event, Emitter<AppState> emit) async {
    Map formerDetail = state.toMap();

    Map newDetail =
        StoreCoinsSuccessState(listOfCoinEntity: event.listOfCoinEntity)
            .toMap();
    newDetail.forEach(
      (key, value) {
        formerDetail[key] = value;
      },
    );
    StoreCoinsSuccessState storeCoinsSuccessState =
        StoreCoinsSuccessState.fromAppState(state.fromMap(formerDetail));
    emit(state.fromMap(formerDetail));
  }

  Future<void> _onStoreUserBalancesEvent(
      StoreUserBalancesEvent event, Emitter<AppState> emit) async {
    Map formerDetail = state.toMap();

    Map newDetail = StoreUserBalancesSuccessState(
            listOfWalletAccounts: event.listOfWalletAccountEntity)
        .toMap();
    newDetail.forEach(
      (key, value) {
        formerDetail[key] = value;
      },
    );
    StoreUserBalancesSuccessState storeUserBalancesSuccessState =
        StoreUserBalancesSuccessState.fromAppState(state.fromMap(formerDetail));
    emit(state.fromMap(formerDetail));
  }

  // _onStoreCoinsEvent
}
