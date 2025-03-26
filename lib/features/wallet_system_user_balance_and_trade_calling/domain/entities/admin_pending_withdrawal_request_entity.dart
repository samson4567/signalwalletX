import 'package:equatable/equatable.dart';

class AdminPendingWithdrawalRequestEntity extends Equatable {
  final String? userID;
  final String? currency;
  final String? chain;
  final String? amount;
  final String? handlingFee;
  final String? type;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? withdrawAddress;

  final String? id;
  final String? totalDeduction;

  const AdminPendingWithdrawalRequestEntity({
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.withdrawAddress,
    required this.userID,
    required this.id,
    required this.currency,
    required this.chain,
    required this.amount,
    required this.handlingFee,
    required this.totalDeduction,
  });

  @override
  List<Object?> get props => [
        userID,
        currency,
        id,
        totalDeduction,
      ];
}


// {
//             "id": 8,
//             "user_id": 19,
//             "currency": "SHIB",
//             "chain": "TRX",
//             "amount": "80.00000000",
//             "handling_fee": "4.00000000",
//             "total_deduction": "84.00000000",
//             "withdraw_address": "TF5CXi6jFeNGDZZNNFbnvih8ERfAB75Sc2",
//             "type": "withdraw",
//             "status": "pending",
//             "created_at": "2025-03-10T07:02:38.000000Z",
//             "updated_at": "2025-03-10T07:02:38.000000Z"
//         },