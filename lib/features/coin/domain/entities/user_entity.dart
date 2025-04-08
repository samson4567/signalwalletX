import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/wallet_account_balance_model.dart';

class UserEntity extends Equatable {
  final String? uid;
  final int? id;
  final String? name;

  final String? email;
  final String? role;
  final bool? isVerified;

  final List<WalletAccountModel>? wallets;

  const UserEntity({
    required this.email,
    required this.uid,
    required this.wallets,
    required this.role,
    required this.isVerified,
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [
        email,
        uid,
        wallets,
        role,
        isVerified,
        name,
        id,
      ];
}



// {
//             "from_currency": "BTC",
//             "to_currency": "USDT",
//             "from_amount": "0.05000000",
//             "to_amount": "4123.92050000",
//             "rate": "82478.41000000",
//             "created_at": "2025-03-18T12:54:52.000000Z"
//         },

// {
//     "message": "Conversion successful.",
//     "from_currency": "BTC",
//     "to_currency": "USDT",
//     "amount_converted": 0.05,
//     "converted_amount": 4123.9205,
//     "rate": "82478.41000000"
// }