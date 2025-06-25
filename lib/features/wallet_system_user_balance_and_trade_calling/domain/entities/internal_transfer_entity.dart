import 'package:equatable/equatable.dart';

class InternalTransferEntity extends Equatable {
  final String? currency;
  final String? amount;
  final String? fromAccount;
  final String? toAccount;
  final String fromWallet;
  final String toWallet;

  const InternalTransferEntity({
    required this.toAccount,
    required this.fromAccount,
    required this.currency,
    required this.amount,
    required this.fromWallet,
    required this.toWallet,
  });

  @override
  List<Object?> get props => [
        toAccount,
        fromAccount,
        currency,
        amount,
      ];
}

// {
//     "currency": "ETH",
//     "from_account": "exchange",
//     "to_account": "trade",
//     "amount": 200
// }