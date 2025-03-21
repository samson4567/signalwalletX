import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/app_bloc/data/models/user_model.dart';

sealed class AppState extends Equatable {
  AppState({this.user});
  UserModel? user = UserModel.empty();

  @override
  List<Object> get props => [];
}

final class AppInitial extends AppState {
  AppInitial();
}

// user update States
final class UserUpdateLoadingState extends AppState {
  UserUpdateLoadingState();
}

final class UserUpdateSuccessState extends AppState {
  @override
  UserModel? user = UserModel.empty();
  UserUpdateSuccessState({required this.user}) {}

  @override
  List<Object> get props => [user!];
}

final class UserUpdateErrorState extends AppState {
  final String errorMessage;

  UserUpdateErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
