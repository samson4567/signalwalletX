import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/core/mapper/failure_mapper.dart';
import 'package:signalwavex/features/authentication/data/datasources/authentication_local_datasource.dart';
import 'package:signalwavex/features/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/authentication/domain/entities/verify_sign_up_entity.dart';
import 'package:signalwavex/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:signalwavex/features/trading_system/data/datasources/trading_system_local_datasource.dart';
import 'package:signalwavex/features/trading_system/data/datasources/trading_system_remote_datasource.dart';
import 'package:signalwavex/features/trading_system/domain/entities/live_market_price_entity.dart';
import 'package:signalwavex/features/trading_system/domain/repositories/trading_system_repository.dart';

class TradingSystemRepositoryImpl implements TradingSystemRepository {
  TradingSystemRepositoryImpl({
    required this.tradingSystemRemoteDatasource,
    required this.tradingSystemLocalDatasource,
  });

  final TradingSystemRemoteDatasource tradingSystemRemoteDatasource;
  final TradingSystemLocalDatasource tradingSystemLocalDatasource;

  @override
  Future<Either<Failure, String>> newUserSignUp(
      {required NewUserRequestModel newUserRequest}) async {
    try {
      final result = await tradingSystemRemoteDatasource.newUserSignUp(
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
      final result = await tradingSystemRemoteDatasource.verifySignUp(
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
          await tradingSystemRemoteDatasource.resendOtp(email: email);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Map>> login(
      {required String email, required String password}) async {
    try {
      final result = await tradingSystemRemoteDatasource.login(
          email: email, password: password);
      await tradingSystemLocalDatasource.saveAuthToken(result["token"]);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> logout({required String token}) async {
    try {
      final result = await tradingSystemRemoteDatasource.logout(token: token);
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
      final result = await tradingSystemRemoteDatasource.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<LiveMarketPriceEntity>>>
      fetchLiveMarketPrices() async {
    try {
      final result =
          await tradingSystemRemoteDatasource.fetchLiveMarketPrices();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
