import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/app_bloc/data/models/user_model.dart';
import 'package:signalwavex/features/user/data/models/user_model.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';

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

final class StoreUserBalancesEvent extends AppEvent {
  final List<WalletAccountEntity> listOfWalletAccountEntity;

  const StoreUserBalancesEvent({
    required this.listOfWalletAccountEntity,
  });

  @override
  List<Object> get props => [listOfWalletAccountEntity];
}
