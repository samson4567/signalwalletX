import 'package:equatable/equatable.dart';

class WithdrawEntity extends Equatable {
  final String currency;
  final String chain;
  final double amount;
  final String withdrawAddress;

  const WithdrawEntity({
    required this.currency,
    required this.chain,
    required this.amount,
    required this.withdrawAddress,
    required String coin,
    required String address,
  });

  @override
  List<Object?> get props => [
        currency,
        chain,
        amount,
        withdrawAddress,
      ];
}
