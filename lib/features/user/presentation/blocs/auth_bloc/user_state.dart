import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/user/data/models/user_model.dart';
import 'package:signalwavex/features/user/domain/entities/referral_code_response_entity.dart';
import 'package:signalwavex/features/user/domain/entities/referral_lists_response_entity.dart';

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

///// KycVerification
final class KycVerificationLoadingState extends UserState {
  const KycVerificationLoadingState();
}

final class KycVerificationSuccessState extends UserState {
  final String message;

  const KycVerificationSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class KycVerificationErrorState extends UserState {
  final String errorMessage;

  const KycVerificationErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// KycVerification ended .....

///// GetRefferalCode
final class GetRefferalCodeLoadingState extends UserState {
  const GetRefferalCodeLoadingState();
}

final class GetRefferalCodeSuccessState extends UserState {
  final ReferralCodeResponseEntity referralCodeResponseEntity;

  const GetRefferalCodeSuccessState({required this.referralCodeResponseEntity});

  @override
  List<Object> get props => [referralCodeResponseEntity];
}

final class GetRefferalCodeErrorState extends UserState {
  final String errorMessage;

  const GetRefferalCodeErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// GetRefferalCode ended .....

///// GetRefferalList
final class GetRefferalListLoadingState extends UserState {
  const GetRefferalListLoadingState();
}

final class GetRefferalListSuccessState extends UserState {
  final ReferralListsResponseEntity referralListsResponseEntity;

  const GetRefferalListSuccessState(
      {required this.referralListsResponseEntity});

  @override
  List<Object> get props => [referralListsResponseEntity];
}

final class GetRefferalListErrorState extends UserState {
  final String errorMessage;

  const GetRefferalListErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
///// GetRefferalList ended .....


// GetRefferalList