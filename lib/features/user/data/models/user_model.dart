import 'package:signalwavex/features/user/domain/entities/user_entity.dart';

import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/data/models/wallet_account_balance_model.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.email,
    super.uid,
    super.wallets,
    super.role,
    super.isVerified,
    super.name,
    super.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "id": id,
      "name": name,
      "email": email,
      "role": role,
      "is_verified": isVerified,
      "wallets": wallets?.map(
        (wallet) => wallet.toJson(),
      )
    };
  }

  factory UserModel.fromJson(Map jsonMap) {
    return UserModel(
      uid: jsonMap["uid"],
      id: jsonMap["id"],
      name: jsonMap["name"],
      email: jsonMap["email"] ?? jsonMap["phone"],
      role: jsonMap["role"],
      isVerified: jsonMap["is_verified"],
      wallets: (jsonMap["wallets"] as List?)
          ?.map(
            (e) => WalletAccountModel.fromJson(e),
          )
          .toList(),
    );
  }

  factory UserModel.empty() {
    return const UserModel();
  }

  factory UserModel.createFromLogin(Map json) {
    return UserModel(
      email: json["email"] ?? json["phone"] ?? "",
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      uid: json["uid"] ?? "",
      role: json["role"] ?? "",
    );
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}



/*{
    "uid": "bA9wPAW8P9IMaU7E",
    "id": 46,
    "name": "Signalwavesfx1",
    "email": "signalwavesfx@gmail.com",
    "role": "trader",
    "is_verified": true,

    "wallets": [
        {
            "account_type": "exchange",
            "currency": "USDT",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "exchange",
            "currency": "ETH",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "exchange",
            "currency": "BTC",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "exchange",
            "currency": "USDC",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "exchange",
            "currency": "DAI",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "exchange",
            "currency": "SHIB",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "trade",
            "currency": "USDT",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "trade",
            "currency": "ETH",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "trade",
            "currency": "BTC",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "trade",
            "currency": "USDC",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "trade",
            "currency": "DAI",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "trade",
            "currency": "SHIB",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "perpetual",
            "currency": "USDT",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "perpetual",
            "currency": "ETH",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "perpetual",
            "currency": "BTC",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "perpetual",
            "currency": "USDC",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "perpetual",
            "currency": "DAI",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        },
        {
            "account_type": "perpetual",
            "currency": "SHIB",
            "actual_quantity": "0.00000000",
            "freeze_quantity": "0.00000000"
        }
    ]

}

 */
