import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/core/mapper/failure_mapper.dart';
import 'package:signalwavex/features/authentication/data/datasources/authentication_local_datasource.dart';
import 'package:signalwavex/features/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/authentication/domain/entities/kyc_enitity.dart';
import 'package:signalwavex/features/authentication/domain/entities/language_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/prelogin_detail_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/recent_transaction_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/transaction_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/verify_sign_up_entity.dart';
import 'package:signalwavex/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.authenticationRemoteDatasource,
    required this.authenticationLocalDatasource,
  });

  final AuthenticationRemoteDatasource authenticationRemoteDatasource;
  final AuthenticationLocalDatasource authenticationLocalDatasource;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
  Future<Either<Failure, Map>> login(
      {required String email, required String password}) async {
    try {
      final result = await authenticationRemoteDatasource.login(
          email: email, password: password);
      await authenticationLocalDatasource.saveAuthToken(result["token"]);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
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

  @override
  Future<Either<Failure, Map>> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return const Left(ServerFailure(
          message: 'Google sign-in canceled',
        ));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;
      print(
          "debug_print-AuthenticationRepositoryImpl-googleSignIn-$googleUser");
      if (accessToken != null) {
        // return Right(idToken); // or you could use accessToken

        try {
          final result = await authenticationRemoteDatasource
              .uploadGoogleSignInToken(token: accessToken);

          await authenticationLocalDatasource.saveAuthToken(result["token"]);
          return right(result);
        } catch (e) {
          return left(mapExceptionToFailure(e));
        }
      } else {
        return const Left(ServerFailure(
          message: 'Failed to retrieve Google tokens',
        ));
      }
    } catch (e) {
      return Left(ServerFailure(
        message: 'Google sign-in failed: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(
      {required String email}) async {
    try {
      final result =
          await authenticationRemoteDatasource.forgetPassword(email: email);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<RecentTransactionEntity>>> getRecentTransactions({
    required String userId,
  }) async {
    try {
      final result = await authenticationRemoteDatasource.getRecentTransactions(
        userId: userId,
      );

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({required String otp}) async {
    try {
      final result = await authenticationRemoteDatasource.verifyOtp(otp: otp);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> setNewPassword(
      {required email, required passoword, required confirmPassword}) async {
    try {
      final result = await authenticationRemoteDatasource.setNewPassword(
          email: email, password: passoword, confirmPassword: confirmPassword);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, LanguagesEntity>> fetchLanguages(
      {required name, required code}) async {
    try {
      final result = await authenticationRemoteDatasource.fetchLanguages(
          code: code, name: name);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfile(
      {required String name,
      required String phoneNumber,
      required File profilePicture}) async {
    try {
      final result = await authenticationRemoteDatasource.updateProfile(
          name: name, phoneNumber: phoneNumber, profilePicture: profilePicture);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactionHistory({
    required String userId,
  }) async {
    try {
      final List<TransactionEntity> result =
          await authenticationRemoteDatasource.getTransactionHistory(
              userId: userId);
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, PreloginDetailEntity>> loadPreloginDetail() async {
    try {
      final result = await authenticationLocalDatasource.loadPreloginDetail();
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> savePreloginDetail(
      {required PreloginDetailEntity preloginDetailEntity}) async {
    try {
      final result = await authenticationLocalDatasource.savePreloginDetail(
        preloginDetailEntity: preloginDetailEntity,
      );
      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
