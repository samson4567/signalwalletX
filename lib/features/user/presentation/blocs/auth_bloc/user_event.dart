import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/user/domain/entities/kyc_request_entity.dart';

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

final class KycVerificationEvent extends UserEvent {
  final KycRequestEntity kycRequestEntity;
  const KycVerificationEvent(this.kycRequestEntity);

  @override
  List<Object> get props => [kycRequestEntity];
}

final class GetRefferalCodeEvent extends UserEvent {
  const GetRefferalCodeEvent();

  @override
  List<Object> get props => [];
}

final class GetRefferalListEvent extends UserEvent {
  const GetRefferalListEvent();

  @override
  List<Object> get props => [];
}


// GetRefferalList