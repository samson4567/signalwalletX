import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/trade_withdrawal_request_request_entity.dart';

class TradeWithdrawalRequestRequestModel
    extends TradeWithdrawalRequestRequestEntity {
  const TradeWithdrawalRequestRequestModel({
    super.withdrawPassword,
    super.amount,
    super.password,
    super.withdrawAddress,
    super.currency,
    super.chain,
  });

  Map<String, dynamic> toJson() {
    return {
      "currency": currency,
      "chain": chain,
      "amount": amount,
      "withdraw_address": withdrawAddress,
      "password": password,
      "withdraw_password": withdrawPassword,
    };
  }

  factory TradeWithdrawalRequestRequestModel.fromJson(Map jsonMap) {
    return TradeWithdrawalRequestRequestModel(
      currency: jsonMap["currency"],
      chain: jsonMap["chain"],
      amount: jsonMap["amount"],
      withdrawAddress: jsonMap["withdraw_address"],
      password: jsonMap["password"],
      withdrawPassword: jsonMap["withdraw_password"],
    );
  }

  factory TradeWithdrawalRequestRequestModel.empty(Map jsonMap) {
    return TradeWithdrawalRequestRequestModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}
