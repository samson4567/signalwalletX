import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
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

  Future<Either<Failure, String>> googleSignIn();
  Future<Either<Failure, String>> forgetPassword({required String email});
}
