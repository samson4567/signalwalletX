import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/domain/entities/withdraw_entity.dart';

class WithdrawModel extends WithdrawEntity {
  const WithdrawModel({
    required super.currency,
    required super.chain,
    required super.amount,
    required super.withdrawAddress,
    required super.coin,
    required super.address,
  });

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      currency: json['currency'],
      chain: json['chain'],
      amount: json['amount'].toDouble(),
      withdrawAddress: json['withdraw_address'],
      coin: '',
      address: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'chain': chain,
      'amount': amount,
      'withdraw_address': withdrawAddress,
    };
  }
}
