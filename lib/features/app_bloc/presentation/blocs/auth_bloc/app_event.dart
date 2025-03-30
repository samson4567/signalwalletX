import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/app_bloc/data/models/user_model.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

final class UserUpdateEvent extends AppEvent {
  final UserModel updatedUserModel;

  const UserUpdateEvent({
    required this.updatedUserModel,
  });

  @override
  List<Object> get props => [updatedUserModel.toJson()];
}

final class StorePNLEvent extends AppEvent {
  final String pnl;

  const StorePNLEvent({
    required this.pnl,
  });

  @override
  List<Object> get props => [pnl];
}
