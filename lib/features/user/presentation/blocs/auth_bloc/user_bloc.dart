import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/core/app_variables.dart';
// import 'package:signalwavex/features/app_bloc/data/models/user_model.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_event.dart';
import 'package:signalwavex/features/user/data/models/user_model.dart';
// import 'package:signalwavex/features/user/data/models/user_model.dart';
import 'package:signalwavex/features/user/domain/repositories/user_repository.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_event.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  AppBloc appBloc;

  UserBloc({required this.userRepository, required this.appBloc})
      : super(const UserInitial()) {
    on<GetUserDetailEvent>(_onGetUserDetailEvent);
    on<KycVerificationEvent>(_onKycVerificationEvent);

    // KycVerification
  }

  Future<void> _onGetUserDetailEvent(
      GetUserDetailEvent event, Emitter<UserState> emit) async {
    emit(const GetUserDetailLoadingState());
    final result = await userRepository.getUserDetails();
    result.fold(
      (error) => emit(GetUserDetailErrorState(errorMessage: error.message)),
      (userModel) {
        userModelG = userModel;
        appBloc
            .add(UserUpdateEvent(updatedUserModel: (userModel as UserModel)));
        emit(GetUserDetailSuccessState(userModel: userModel));
      },
    );
  }

  Future<void> _onKycVerificationEvent(
      KycVerificationEvent event, Emitter<UserState> emit) async {
    emit(const KycVerificationLoadingState());
    final result = await userRepository.kycVerification();
    result.fold(
      (error) => emit(KycVerificationErrorState(errorMessage: error.message)),
      (message) {
        emit(KycVerificationSuccessState(message: message));
      },
    );
  }

  // _onKycVerificationEvent
}
