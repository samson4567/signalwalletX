import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';

class WalletAccountBalanceModel extends WalletAccountBalanceEntity {
  const WalletAccountBalanceModel({
    super.accountType,
    super.actualQuantity,
    super.currency,
    super.freezeQuantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "account_type": accountType,
      "currency": currency,
      "actual_quantity": accountType,
      "freeze_quantity": freezeQuantity
    };
  }

  factory WalletAccountBalanceModel.fromJson(Map jsonMap) {
    return WalletAccountBalanceModel(
      accountType: jsonMap["account_type"],
      actualQuantity: jsonMap["actual_quantity"],
      currency: jsonMap["currency"],
      freezeQuantity: jsonMap["freeze_quantity"],
    );
  }

  factory WalletAccountBalanceModel.empty(Map jsonMap) {
    return WalletAccountBalanceModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}
