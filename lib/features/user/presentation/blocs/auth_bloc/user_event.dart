import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class GetUserDetailEvent extends UserEvent {
  const GetUserDetailEvent();

  @override
  List<Object> get props => [];
}
