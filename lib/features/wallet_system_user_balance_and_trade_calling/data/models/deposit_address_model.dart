import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/deposit_address_entity.dart';

class DepositAddressModel extends DepositAddressEntity {
  const DepositAddressModel({
    super.qRCode,
    super.depositAddress,
    super.currency,
    super.chain,
  });

  Map<String, dynamic> toJson() {
    return {
      "chain": chain,
      "deposit_address": depositAddress,
      "currency": currency,
      "qr_code": qRCode,
    };
  }

  factory DepositAddressModel.fromJson(Map jsonMap) {
    return DepositAddressModel(
      chain: jsonMap["chain"],
      depositAddress: jsonMap["deposit_address"],
      currency: jsonMap["currency"],
      qRCode: jsonMap["qr_code"],
    );
  }

  factory DepositAddressModel.empty(Map jsonMap) {
    return const DepositAddressModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}
