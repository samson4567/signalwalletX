import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/authentication/domain/entities/language_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/prelogin_detail_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/recent_transaction_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/transaction_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/verify_sign_up_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, String>> newUserSignUp(
      {required NewUserRequestModel newUserRequest});
  Future<Either<Failure, VerifySignUpEntity>> verifySignUp(
      {required String email, required String otp});
  Future<Either<Failure, String>> resendOtp({required String email});
  Future<Either<Failure, Map>> login(
      {required String email, required String password});
  Future<Either<Failure, String>> logout({required String token});
  Future<Either<Failure, String>> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  });

  Future<Either<Failure, Map>> googleSignIn();
  Future<Either<Failure, String>> forgetPassword({required String email});
  Future<Either<Failure, List<RecentTransactionEntity>>> getRecentTransactions({
    required String userId,
  });
  Future<Either<Failure, String>> verifyOtp({required String otp});
  Future<Either<Failure, String>> setNewPassword(
      {required email, required passoword, required confirmPassword});

  Future<Either<Failure, LanguagesEntity>> fetchLanguages(
      {required name, required code});
  Future<Either<Failure, String>> updateProfile(
      {required String name,
      required String phoneNumber,
      required String profilePicture});

  Future<Either<Failure, PreloginDetailEntity>> loadPreloginDetail();
  Future<Either<Failure, void>> savePreloginDetail(
      {required PreloginDetailEntity preloginDetailEntity});

  Future<Either<Failure, List<TransactionEntity>>> getTransactionHistory({
    required String userId,
  });
}
