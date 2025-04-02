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
    print("debug_print__onUserUpdate-bsakjdkjdakdhh_initial-");
    print("formerDetailformerDetail--111-asdjasdaskjdasbd${formerDetail}");
    // emit(UserUpdateLoadingState.fromAppState(state.fromMap(formerDetail)));

    Map newDetail = UserUpdateSuccessState(
      user: event.updatedUserModel,
    ).toMap();

    newDetail.forEach(
      (key, value) {
        formerDetail[key] = value;
      },
    );
    print("formerDetailformerDetail--2222${newDetail}");
    print("formerDetailformerDetail--3333${formerDetail}");
    // UserUpdateSuccessState userUpdateSuccessState =
    //     UserUpdateSuccessState.fromAppState(state.fromMap(formerDetail));

    // print("formerDetailformerDetail--4444${userUpdateSuccessState.user}");
    // UserUpdateSuccessState(user: user).;
    emit(state.fromMap(formerDetail));
  }

  Future<void> _onStorePNLEvent(
      StorePNLEvent event, Emitter<AppState> emit) async {
    Map formerDetail = state.toMap();
    print(
        "debug_print__onStorePNLEvent-formerDetail-asdjasdaskjdasbd${formerDetail}");
    // emit(StorePNLLoadingState.fromAppState(state.fromMap(formerDetail)));

    Map newDetail = StorePNLSuccessState(pnl: event.pnl).toMap();
    newDetail.forEach(
      (key, value) {
        formerDetail[key] = value;
      },
    );
    StorePNLSuccessState storePNLSuccessState =
        StorePNLSuccessState.fromAppState(state.fromMap(formerDetail));
    print(
        "debug_print__onStorePNLEvent-storePNLSuccessState${storePNLSuccessState.toMap()}");
    emit(state.fromMap(formerDetail));
  }

  Future<void> _onStoreCoinsEvent(
      StoreCoinsEvent event, Emitter<AppState> emit) async {
    Map formerDetail = state.toMap();
    print(
        "debug_print__onStorePNLEvent-formerDetail-asdjasdaskjdasbd${formerDetail}");
    // emit(StoreCoinsLoadingState.fromAppState(state.fromMap(formerDetail)));

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
    print(
        "debug_print__onStorePNLEvent-formerDetail-asdjasdaskjdasbd${formerDetail}");
    // emit(StoreUserBalancesLoadingState.fromAppState(
    //     state.fromMap(formerDetail)));

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
