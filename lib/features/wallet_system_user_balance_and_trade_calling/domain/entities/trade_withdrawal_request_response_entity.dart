import 'package:equatable/equatable.dart';

class TradeWithdrawalRequestResponseEntity extends Equatable {
  final double? totalDeduction;
  final double? handlingFee;
  final double? amount;

  const TradeWithdrawalRequestResponseEntity({
    required this.handlingFee,
    required this.amount,
    required this.totalDeduction,
  });

  @override
  List<Object?> get props => [
        totalDeduction,
        handlingFee,
        amount,
      ];
}

// {
//     "message": "Withdrawal request submitted. Pending admin approval.",
//     "amount": 80,
//     "handling_fee": 4,
//     "total_deduction": 84
// }