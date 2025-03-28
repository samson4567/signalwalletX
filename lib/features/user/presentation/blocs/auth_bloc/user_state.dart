import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/user/data/models/user_model.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {
  const UserInitial();
}

///// GetUserDetail
final class GetUserDetailLoadingState extends UserState {
  const GetUserDetailLoadingState();
}

final class GetUserDetailSuccessState extends UserState {
  final UserModel userModel;

  const GetUserDetailSuccessState({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

final class GetUserDetailErrorState extends UserState {
  final String errorMessage;

  const GetUserDetailErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// GetUserDetail ended .....
