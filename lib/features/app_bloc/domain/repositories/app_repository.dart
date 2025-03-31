import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/features/user/data/models/user_model.dart';

abstract class AppRepository {
  Future<Either<Failure, String>> updateUser({required UserModel userModel});
}
