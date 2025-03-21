import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';

import 'package:signalwavex/features/app_bloc/data/datasources/app_local_datasource.dart';
import 'package:signalwavex/features/app_bloc/data/datasources/app_remote_datasource.dart';
import 'package:signalwavex/features/app_bloc/data/models/user_model.dart';
import 'package:signalwavex/features/app_bloc/domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  AppRepositoryImpl({
    required this.appRemoteDatasource,
    required this.appLocalDatasource,
  });

  final AppRemoteDatasource appRemoteDatasource;
  final AppLocalDatasource appLocalDatasource;

  @override
  Future<Either<Failure, String>> updateUser({required UserModel userModel}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
