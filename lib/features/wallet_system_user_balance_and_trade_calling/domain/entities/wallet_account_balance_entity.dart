import 'package:equatable/equatable.dart';

class WalletAccountBalanceEntity extends Equatable {
  final String? accountType;
  final String? currency;
  final String? actualQuantity;
  final String? freezeQuantity;

  const WalletAccountBalanceEntity({
    required this.accountType,
    required this.actualQuantity,
    required this.currency,
    required this.freezeQuantity,
  });

  @override
  List<Object?> get props => [
        accountType,
        currency,
        actualQuantity,
        freezeQuantity,
      ];
}
