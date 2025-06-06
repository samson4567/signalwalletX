import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/core/mapper/failure_mapper.dart';
import 'package:signalwavex/features/user/data/datasources/user_local_datasource.dart';
import 'package:signalwavex/features/user/data/datasources/user_remote_datasource.dart';
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
  Future<Either<Failure, String>> kycVerification() async {
    try {
      final result = await userRemoteDatasource.kycVerification();

      return right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
