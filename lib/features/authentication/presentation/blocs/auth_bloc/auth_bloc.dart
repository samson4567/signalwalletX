import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_event.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/authentication/data/models/transaction_model.dart';
import 'package:signalwavex/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:signalwavex/features/user/data/models/user_model.dart';

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
    on<UpdatePasswordEvent>(_onUpdatePasswordEvent);
    on<GoogleAuthEvent>(_onGoogleAuthEvent);
    on<ForgetPasswordEvent>(_onForgetPasswordEvent);
    on<FetchRecentTransactions>(_onRecentTransactionEvent);
    on<OtpVerificationEvent>(_onOtpVerificationEvent);
    on<SetNewPasswordEvent>(_onSetNewPasswordEvent);
    on<ProfileUpdateEvent>(_onProfileUpdateEvent);
    // on<FetchAllLanguagesEvent>(_onFetechAllLanguages);
    on<GoogleLoginEvent>(_onGoogleLoginEvent);
    on<LoadPreloginDetailsEvent>(_onLoadPreloginDetailsEvent);
    on<SavePreloginDetailsEvent>(_onSavePreloginDetailsEvent);
    on<FetchTransactionHistoryEvent>(_onFetchTransactionHistoryEvent);
  }

// SavePreloginDetails
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

  Future<void> _onUpdatePasswordEvent(
      UpdatePasswordEvent event, Emitter<AuthState> emit) async {
    emit(const UpdatePasswordLoadingState());

    final result = await authenticationRepository.updatePassword(
      currentPassword: event.currentPassword,
      newPassword: event.newPassword,
      newPasswordConfirmation: event.newPasswordConfirmation,
    );

    result.fold(
      (error) => emit(UpdatePasswordErrorState(errorMessage: error.message)),
      (message) => emit(UpdatePasswordSuccessState(message: message)),
    );
  }

  Future<void> _onGoogleAuthEvent(
    GoogleAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const GoogleAuthLoadingState());

    // Call the googleSignIn method from the repository
    final result = await authenticationRepository.googleSignIn();

    result.fold(
      (error) => emit(GoogleAuthErrorState(error.message, errorMessage: '')),
      (idToken) {
        appBloc.add(
          UserUpdateEvent(
            updatedUserModel: UserModel.createFromLogin({
              "email": event.googleUser.email,
              "idToken": idToken,
            }),
          ),
        );
        emit(const GoogleAuthSuccessState(message: '')); // Emit success state
      },
    );
  }

  Future<void> _onForgetPasswordEvent(
      ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(const ForgetPasswordLoadingState());

    final result = await authenticationRepository.forgetPassword(
      email: event.email,
    );

    result.fold(
      (error) => emit(ForgetPasswordErrorState(errorMessage: error.message)),
      (message) => emit(ForgetPasswordSuccessState(message: message)),
    );
  }

  Future<void> _onRecentTransactionEvent(
    FetchRecentTransactions event,
    Emitter<AuthState> emit,
  ) async {
    emit(const RecentTransactionLoadingState());

    try {
      final result = await authenticationRepository.getRecentTransactions(
        userId: event.userId,
      );

      result.fold(
        (error) {
          emit(RecentTransactionErrorState(errorMessage: error.message));
        },
        (transactions) {
          if (transactions.isEmpty) {
            emit(const RecentTransactionSuccessState(transactions: []));
          } else {
            emit(RecentTransactionSuccessState(transactions: transactions));
          }
        },
      );
    } catch (e) {
      // Emit error state if an exception occurs
      emit(RecentTransactionErrorState(
        errorMessage:
            e is Exception ? e.toString() : 'An unknown error occurred',
      ));
    }
  }

  Future<void> _onOtpVerificationEvent(
    OtpVerificationEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const OtpVerificationLoadingState());

    final result = await authenticationRepository.verifyOtp(
      otp: event.otp,
    );

    result.fold(
      (error) => emit(OtpVerificationErrorState(errorMessage: error.message)),
      (message) => emit(OtpVerificationSuccessState(message: message)),
    );
  }

  Future<void> _onSetNewPasswordEvent(
    SetNewPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const SetNewPasswordLoadingState());

    final result = await authenticationRepository.setNewPassword(
      email: event.email,
      passoword: event.password,
      confirmPassword: event.confirmPassword,
    );

    result.fold(
      (error) => emit(SetNewPasswordErrorState(errorMessage: error.message)),
      (message) => emit(SetNewPasswordSuccessState(message: message)),
    );
  }

  Future<void> _onProfileUpdateEvent(
      ProfileUpdateEvent event, Emitter<AuthState> emit) async {
    emit(const ProfileUpdateLoadingState());

    try {
      final result = await authenticationRepository.updateProfile(
        name: event.name,
        phoneNumber: event.phoneNumber,
        profilePicture: event.profilePicture,
      );

      result.fold(
        (error) => emit(ProfileUpdateErrorState(errorMessage: error.message)),
        (message) => emit(ProfileUpdateSuccessState(
          message: message,
        )),
      );
    } catch (e) {
      emit(ProfileUpdateErrorState(
        errorMessage:
            e is Exception ? e.toString() : 'An unknown error occurred',
      ));
    }
  }

  Future<void> _onGoogleLoginEvent(
      GoogleLoginEvent event, Emitter<AuthState> emit) async {
    emit(const GoogleLoginLoadingState());

    try {
      final result = await authenticationRepository.googleSignIn();

      result.fold(
        (error) => emit(GoogleLoginErrorState(errorMessage: error.message)),
        (details) => emit(GoogleLoginSuccessState(
          message: details["message"] ?? "",
          email: details["user"]["email"] ?? "",
        )),
      );
    } catch (e) {
      emit(GoogleLoginErrorState(
        errorMessage:
            e is Exception ? e.toString() : 'An unknown error occurred',
      ));
    }
  }

  Future<void> _onLoadPreloginDetailsEvent(
      LoadPreloginDetailsEvent event, Emitter<AuthState> emit) async {
    emit(const LoadPreloginDetailsLoadingState());

    try {
      final result = await authenticationRepository.loadPreloginDetail();

      result.fold(
        (error) =>
            emit(LoadPreloginDetailsErrorState(errorMessage: error.message)),
        (preloginDetail) => emit(
            LoadPreloginDetailsSuccessState(preloginDetail: preloginDetail)),
      );
    } catch (e) {
      emit(LoadPreloginDetailsErrorState(
        errorMessage:
            e is Exception ? e.toString() : 'An unknown error occurred',
      ));
    }
  }

  Future<void> _onSavePreloginDetailsEvent(
      SavePreloginDetailsEvent event, Emitter<AuthState> emit) async {
    emit(const SavePreloginDetailsLoadingState());

    try {
      final result = await authenticationRepository.loadPreloginDetail();

      result.fold(
        (error) =>
            emit(SavePreloginDetailsErrorState(errorMessage: error.message)),
        (preloginDetail) => emit(const SavePreloginDetailsSuccessState(
            message: "login details saved")),
      );
    } catch (e) {
      emit(SavePreloginDetailsErrorState(
        errorMessage:
            e is Exception ? e.toString() : 'An unknown error occurred',
      ));
    }
  }

  Future<void> _onFetchTransactionHistoryEvent(
    FetchTransactionHistoryEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const FetchTransactionLoadingState());

    try {
      final result = await authenticationRepository.getTransactionHistory(
        userId: event.userId,
      );

      result.fold(
        (error) {
          emit(FetchTransactionErrorState(errorMessage: error.message));
        },
        (transactionEntities) {
          final transactionModels = transactionEntities.map((entity) {
            return TransactionModel(
              id: entity.id,
              userId: entity.userId,
              tid: entity.tid,
              title: entity.title,
              purchaseDuration: entity.purchaseDuration,
              orderTime: entity.orderTime,
              followCondition: entity.followCondition,
              createdByAdmin: entity.createdByAdmin,
              orderId: entity.orderId,
              symbol: entity.symbol,
              side: entity.side,
              type: entity.type,
              price: entity.price,
              quantity: entity.quantity,
              status: entity.status,
              pnl: entity.pnl,
              createdAt: entity.createdAt,
              updatedAt: entity.updatedAt,
            );
          }).toList();

          emit(FetchTransactionLoadedState(transactionModels));
        },
      );
    } catch (e) {
      emit(FetchTransactionErrorState(
        errorMessage:
            e is Exception ? e.toString() : 'An unknown error occurred',
      ));
    }
  }
}
