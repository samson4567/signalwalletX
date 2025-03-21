import 'package:dartz/dartz.dart';
import 'package:signalwavex/core/error/failure.dart';
import 'package:signalwavex/features/app_bloc/data/models/user_model.dart';
import 'package:signalwavex/features/authentication/data/models/new_user_request_model.dart';
import 'package:signalwavex/features/authentication/domain/entities/verify_sign_up_entity.dart';
import 'package:signalwavex/features/authentication/domain/entities/login_entity.dart';

abstract class AppRepository {
  Future<Either<Failure, String>> updateUser({required UserModel userModel});
}
