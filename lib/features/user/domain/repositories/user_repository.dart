import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/features/user/domain/entities/kyc_request_entity.dart';
import 'package:signalwavex/features/user/domain/entities/referral_code_response_entity.dart';
import 'package:signalwavex/features/user/domain/entities/referral_lists_response_entity.dart';
import 'package:signalwavex/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserDetails();
  Future<Either<Failure, String>> kycVerification(
      {required KycRequestEntity kycRequestEntity});
  Future<Either<Failure, ReferralListsResponseEntity>> getRefferalList();
  Future<Either<Failure, ReferralCodeResponseEntity>> getRefferalCode();
}
