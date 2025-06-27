import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/internal_transfer_entity.dart';

// InternalTransferEntity
class InternalTransferModel extends InternalTransferEntity {
  const InternalTransferModel({
    super.toAccount,
    super.fromAccount,
    super.currency,
    super.amount,
    required super.fromWallet,
    required super.toWallet,
  });

  Map<String, dynamic> toJson() {
    return {
      "currency": currency,
      "from_account": fromAccount,
      "to_account": toAccount,
      "amount": amount,
      "from_wallet": fromWallet,
      "to_wallet": toWallet,
    };
  }

  Map<String, dynamic> toInternalTransferJson() {
    return {
      "currency": currency,
      "from_account": fromAccount,
      "to_account": toAccount,
      "amount": amount
    };
    // return {
    //   "currency": currency,
    //   "from_account": fromAccount,
    //   "to_account": toAccount,
    //   "amount": amount,
    //   "from_wallet": fromWallet,
    //   "to_wallet": toWallet,
    // };
  }

  factory InternalTransferModel.fromJson(Map jsonMap) {
    return InternalTransferModel(
      currency: jsonMap["currency"],
      amount: jsonMap["amount"],
      fromAccount: jsonMap["from_account"],
      toAccount: jsonMap["to_account"],
      fromWallet: jsonMap["from_wallet"] ?? '',
      toWallet: jsonMap["to_wallet"] ?? '',
    );
  }
  factory InternalTransferModel.fromEntity(
      InternalTransferEntity internalTransferEntity) {
    return InternalTransferModel(
      currency: internalTransferEntity.currency,
      amount: internalTransferEntity.amount,
      fromAccount: internalTransferEntity.fromAccount,
      toAccount: internalTransferEntity.toAccount,
      fromWallet: internalTransferEntity.fromWallet,
      toWallet: internalTransferEntity.toWallet,
    );
  }

  factory InternalTransferModel.empty(Map jsonMap) {
    return const InternalTransferModel(fromWallet: '', toWallet: '');
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}
