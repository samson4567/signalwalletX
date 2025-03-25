import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/features/app_bloc/data/models/user_model.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_event.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository authenticationRepository;
  AppBloc appBloc;

  AuthBloc({required this.authenticationRepository, required this.appBloc})
      : super(const AuthInitial()) {
    on<NewUserSignUpEvent>(_onNewUserSignUpEvent);
    on<VerifyNewSignUpEmailEvent>(_onVerifyNewSignUpEmailEvent);
    on<ResendOtpEvent>(_onResendOtpEvent);
    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onNewUserSignUpEvent(
      NewUserSignUpEvent event, Emitter<AuthState> emit) async {
    emit(const NewUserSignUpLoadingState());
    final result = await authenticationRepository.newUserSignUp(
      newUserRequest: NewUserRequestModel(
        email: event.email,
        password: event.password,
        passwordConfirmation: event.confirmPassword,
      ),
    );
    result.fold(
      (error) => emit(NewUserSignUpErrorState(errorMessage: error.message)),
      (message) => emit(NewUserSignUpSuccessState(message: message)),
    );
  }

  Future<void> _onVerifyNewSignUpEmailEvent(
      VerifyNewSignUpEmailEvent event, Emitter<AuthState> emit) async {
    emit(const VerifyNewSignUpEmailLoadingState());
    final result = await authenticationRepository.verifySignUp(
      email: event.email,
      otp: event.otp,
    );
    result.fold(
      (error) =>
          emit(VerifyNewSignUpEmailErrorState(errorMessage: error.message)),
      (entity) =>
          emit(VerifyNewSignUpEmailSuccessState(message: entity.message)),
    );
  }

  Future<void> _onResendOtpEvent(
      ResendOtpEvent event, Emitter<AuthState> emit) async {
    emit(const ResendOtpLoadingState());
    final result = await authenticationRepository.resendOtp(email: event.email);
    result.fold(
      (error) => emit(ResendOtpErrorState(errorMessage: error.message)),
      (message) => emit(ResendOtpSuccessState(message: message)),
    );
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const LoginLoadingState());
    final result = await authenticationRepository.login(
      email: event.email,
      password: event.password,
    );

    result.fold((error) => emit(LoginErrorState(errorMessage: error.message)),
        (entity) {
      appBloc.add(
        UserUpdateEvent(
          updatedUserModel: UserModel.createFromLogin(
            entity["user"],
          ),
        ),
      );
      emit(LoginSuccessState(
          email: entity["user"]["email"], message: "Login Successful"));
    });
  }

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AuthState> emit) async {
    emit(const LogoutLoadingState());

    final result = await authenticationRepository.logout(token: event.token);

    result.fold(
      (error) => emit(LogoutErrorState(errorMessage: error.message)),
      (message) {
        emit(LogoutSuccessState(message: message));
      },
    );
  }
}
