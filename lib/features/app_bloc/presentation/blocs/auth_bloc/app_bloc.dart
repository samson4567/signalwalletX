import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/features/app_bloc/domain/repositories/app_repository.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_event.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository appRepository;

  AppBloc({required this.appRepository}) : super(AppInitial()) {
    on<UserUpdateEvent>(_onUserUpdate);
    on<StorePNLEvent>(_onStorePNLEvent);
    on<StoreUserBalancesEvent>(_onStoreUserBalancesEvent);

    // StoreUserBalancesEvent
  }

  Future<void> _onUserUpdate(
      UserUpdateEvent event, Emitter<AppState> emit) async {
    emit(UserUpdateLoadingState());
    emit(UserUpdateSuccessState(user: event.updatedUserModel));
  }

  Future<void> _onStorePNLEvent(
      StorePNLEvent event, Emitter<AppState> emit) async {
    emit(StorePNLLoadingState());
    emit(StorePNLSuccessState(pnl: event.pnl));
  }

  Future<void> _onStoreUserBalancesEvent(
      StoreUserBalancesEvent event, Emitter<AppState> emit) async {
    emit(StoreUserBalancesLoadingState());
    emit(StoreUserBalancesSuccessState(
        listOfWalletAccounts: event.listOfWalletAccountEntity));
  }

  // _onStoreUserBalancesEvent
}
