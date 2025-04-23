import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_withdrawal_request_response_entity.dart';

class TradeWithdrawalRequestResponseModel
    extends TradeWithdrawalRequestResponseEntity {
  const TradeWithdrawalRequestResponseModel({
    super.handlingFee,
    super.amount,
    super.totalDeduction,
  });

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "handling_fee": handlingFee,
      "total_deduction": totalDeduction,
    };
  }

  factory TradeWithdrawalRequestResponseModel.fromJson(Map jsonMap) {
    return TradeWithdrawalRequestResponseModel(
      amount: jsonMap["amount"],
      handlingFee: jsonMap["handling_fee"],
      totalDeduction: jsonMap["total_deduction"],
    );
  }

  factory TradeWithdrawalRequestResponseModel.empty(Map jsonMap) {
    return const TradeWithdrawalRequestResponseModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}
