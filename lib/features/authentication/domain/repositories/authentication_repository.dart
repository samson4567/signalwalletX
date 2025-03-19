import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/authentication/domain/entities/verify_sign_up_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/login_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, String>> newUserSignUp(
      {required NewUserRequestModel newUserRequest});
  Future<Either<Failure, VerifySignUpEntity>> verifySignUp(
      {required String email, required String otp});
  Future<Either<Failure, String>> resendOtp({required String email});
  Future<Either<Failure, LoginEntity>> login(
      {required String email, required String password});
}
