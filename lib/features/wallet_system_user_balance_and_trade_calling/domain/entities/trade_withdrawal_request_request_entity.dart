import 'package:equatable/equatable.dart';

class TradeWithdrawalRequestRequestEntity extends Equatable {
  final String? currency;
  final String? chain;
  final String? withdrawAddress;
  final String? password;
  final String? withdrawPassword;
  final double? amount;

  const TradeWithdrawalRequestRequestEntity({
    required this.withdrawPassword,
    required this.amount,
    required this.password,
    required this.withdrawAddress,
    required this.currency,
    required this.chain,
  });

  @override
  List<Object?> get props => [
        password,
        withdrawAddress,
        currency,
        chain,
      ];
}
// {
//     "currency": "SHIB",
//     "chain": "TRX",
//     "amount": 80,
//     "withdraw_address": "TF5CXi6jFeNGDZZNNFbnvih8ERfAB75Sc2",
//     "password": "hyconcodes1",
//     "withdraw_password": "Hyconcodes1@111"
// }