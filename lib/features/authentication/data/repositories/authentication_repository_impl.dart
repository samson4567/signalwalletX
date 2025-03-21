import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/core/mapper/failure_mapper.dart';
import 'package:signalwavex/features/authentication/data/datasources/authentication_local_datasource.dart';
import 'package:signalwavex/features/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/authentication/domain/entities/login_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/verify_sign_up_entity.dart';
import 'package:signalwavex/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.authenticationRemoteDatasource,
    required this.authenticationLocalDatasource,
  });

  final AuthenticationRemoteDatasource authenticationRemoteDatasource;
  final AuthenticationLocalDatasource authenticationLocalDatasource;

  @override
  Future<Either<Failure, String>> newUserSignUp(
      {required NewUserRequestModel newUserRequest}) async {
    try {
      final result = await authenticationRemoteDatasource.newUserSignUp(
          newUserRequest: newUserRequest);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, VerifySignUpEntity>> verifySignUp(
      {required String email, required String otp}) async {
    try {
      final result = await authenticationRemoteDatasource.verifySignUp(
          email: email, otp: otp);
      return right(VerifySignUpEntity(message: result));
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> resendOtp({required String email}) async {
    try {
      final result =
          await authenticationRemoteDatasource.resendOtp(email: email);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> login(
      {required String email, required String password}) async {
    final result = await authenticationRemoteDatasource.login(
        email: email, password: password);
    await authenticationLocalDatasource.saveAuthToken(result);
    return right(LoginEntity(email: email, password: password));
  }

  @override
  Future<Either<Failure, String>> logout({required String token}) async {
    try {
      final result = await authenticationRemoteDatasource.logout(token: token);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final result = await authenticationRemoteDatasource.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
