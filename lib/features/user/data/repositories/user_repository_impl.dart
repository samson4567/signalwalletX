import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/core/mapper/failure_mapper.dart';
import 'package:signalwavex/features/user/data/datasources/user_local_datasource.dart';
import 'package:signalwavex/features/user/data/datasources/user_remote_datasource.dart';
import 'package:signalwavex/features/user/domain/entities/kyc_request_entity.dart';
import 'package:signalwavex/features/user/domain/entities/referral_code_response_entity.dart';
import 'package:signalwavex/features/user/domain/entities/referral_lists_response_entity.dart';
import 'package:signalwavex/features/user/domain/entities/user_entity.dart';
import 'package:signalwavex/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required this.userRemoteDatasource,
    required this.userLocalDatasource,
  });

  final UserRemoteDatasource userRemoteDatasource;
  final UserLocalDatasource userLocalDatasource;

  @override
  Future<Either<Failure, UserEntity>> getUserDetails() async {
    try {
      final result = await userRemoteDatasource.getUserDetails();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> kycVerification(
      {required KycRequestEntity kycRequestEntity}) async {
    try {
      final result = await userRemoteDatasource.kycVerification(
          kycRequestEntity: kycRequestEntity);

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ReferralCodeResponseEntity>> getRefferalCode() async {
    try {
      final result = await userRemoteDatasource.getRefferalCode();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ReferralListsResponseEntity>> getRefferalList() async {
    print("debug_print-UserRepositoryImpl-getRefferalList-start");
    try {
      final result = await userRemoteDatasource.getRefferalList();
      print(
          "debug_print-UserRepositoryImpl-getRefferalList-result_is_${result}");

      return right(result);
    } catch (e) {
      print("debug_print-UserRepositoryImpl-getRefferalList-e_is_${e}");
      return left(mapExceptionToFailure(e));
    }
  }
}
