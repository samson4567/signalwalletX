import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/wallet_account_balance_entity.dart';

class WalletAccountModel extends WalletAccountEntity {
  const WalletAccountModel({
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

  factory WalletAccountModel.fromJson(Map jsonMap) {
    return WalletAccountModel(
      accountType: jsonMap["account_type"],
      actualQuantity: jsonMap["actual_quantity"],
      currency: jsonMap["currency"],
      freezeQuantity: jsonMap["freeze_quantity"],
    );
  }

  factory WalletAccountModel.empty(Map jsonMap) {
    return WalletAccountModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}
