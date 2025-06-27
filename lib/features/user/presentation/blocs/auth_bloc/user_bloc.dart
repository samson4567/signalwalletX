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
import 'dart:developer' as logger;

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  AppBloc appBloc;

  UserBloc({required this.userRepository, required this.appBloc})
      : super(const UserInitial()) {
    on<GetUserDetailEvent>(_onGetUserDetailEvent);
    on<KycVerificationEvent>(_onKycVerificationEvent);
    on<GetRefferalCodeEvent>(_onGetRefferalCodeEvent);

    on<GetRefferalListEvent>(_onGetRefferalListEvent);

    // GetRefferalList
  }

  Future<void> _onGetUserDetailEvent(
      GetUserDetailEvent event, Emitter<UserState> emit) async {
    print("debug_print-UserBloc-_onGetUserDetailEvent-called");
    emit(const GetUserDetailLoadingState());
    // print(
    //     "debug_print-UserBloc-_onGetUserDetailEvent-GetUserDetailLoadingState_emitted");
    final result = await userRepository.getUserDetails();

    result.fold(
      (error) {
        // print("debug_print-UserBloc-_onGetUserDetailEvent-error_is_${error}");
        emit(GetUserDetailErrorState(errorMessage: error.message));
      },
      (userModel) {
        // userModelG = userModel;
        userModelG = UserModel(
          email: userModelG?.email,
          id: userModel.id,
          isVerified: userModel.isVerified,
          name: userModel.name,
          role: userModel.role,
          uid: userModel.uid,
          wallets: userModel.wallets,
        );
        logger.log(
            "debug_print-UserBloc-_onGetUserDetailEvent-userModel_is_${userModel}");
        appBloc
            .add(UserUpdateEvent(updatedUserModel: (userModel as UserModel)));
        emit(GetUserDetailSuccessState(userModel: userModel));
      },
    );
  }

  Future<void> _onKycVerificationEvent(
      KycVerificationEvent event, Emitter<UserState> emit) async {
    emit(const KycVerificationLoadingState());
    final result = await userRepository.kycVerification(
        kycRequestEntity: event.kycRequestEntity);
    result.fold(
      (error) => emit(KycVerificationErrorState(errorMessage: error.message)),
      (message) {
        emit(KycVerificationSuccessState(message: message));
      },
    );
  }

  Future<void> _onGetRefferalCodeEvent(
      GetRefferalCodeEvent event, Emitter<UserState> emit) async {
    emit(const GetRefferalCodeLoadingState());
    final result = await userRepository.getRefferalCode();
    result.fold(
      (error) => emit(GetRefferalCodeErrorState(errorMessage: error.message)),
      (referralCodeResponseEntity) {
        emit(GetRefferalCodeSuccessState(
            referralCodeResponseEntity: referralCodeResponseEntity));
      },
    );
  }

  Future<void> _onGetRefferalListEvent(
      GetRefferalListEvent event, Emitter<UserState> emit) async {
    emit(const GetRefferalListLoadingState());
    final result = await userRepository.getRefferalList();
    result.fold(
      (error) => emit(GetRefferalListErrorState(errorMessage: error.message)),
      (referralListsResponseEntity) {
        emit(GetRefferalListSuccessState(
            referralListsResponseEntity: referralListsResponseEntity));
      },
    );
  }

  // _onGetRefferalListEvent
}
