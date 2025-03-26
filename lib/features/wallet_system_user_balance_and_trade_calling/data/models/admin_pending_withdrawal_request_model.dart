import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/admin_pending_withdrawal_request_entity.dart';

class AdminPendingWithdrawalRequestModel
    extends AdminPendingWithdrawalRequestEntity {
  const AdminPendingWithdrawalRequestModel({
    super.type,
    super.status,
    super.createdAt,
    super.updatedAt,
    super.withdrawAddress,
    super.userID,
    super.id,
    super.currency,
    super.chain,
    super.amount,
    super.handlingFee,
    super.totalDeduction,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userID,
      "currency": currency,
      "chain": chain,
      "amount": amount,
      "handling_fee": handlingFee,
      "total_deduction": totalDeduction,
      "withdraw_address": withdrawAddress,
      "type": type,
      "status": status,
      "created_at": createdAt,
      "updated_at": updatedAt
    };
  }

  factory AdminPendingWithdrawalRequestModel.fromJson(Map jsonMap) {
    return AdminPendingWithdrawalRequestModel(
      id: jsonMap["id"],
      userID: jsonMap["user_id"],
      currency: jsonMap["currency"],
      chain: jsonMap["chain"],
      amount: jsonMap["amount"],
      handlingFee: jsonMap["handling_fee"],
      totalDeduction: jsonMap["total_deduction"],
      withdrawAddress: jsonMap["withdraw_address"],
      type: jsonMap["type"],
      status: jsonMap["status"],
      createdAt: jsonMap["created_at"],
      updatedAt: jsonMap["updated_at"],
    );
  }

  factory AdminPendingWithdrawalRequestModel.empty(Map jsonMap) {
    return AdminPendingWithdrawalRequestModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
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