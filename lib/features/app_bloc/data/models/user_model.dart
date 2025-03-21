import 'package:signalwavex/features/app_bloc/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.id,
    required super.name,
    required super.pid,
    required super.username,
    required super.verified,
    required super.isBanned,
    required super.slug,
    required super.hasInterests,
    required super.authProvider,
    required super.ipAddress,
    required super.twoFactorPassed,
    required super.walletAddress,
    required super.bragWalletBalance,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // email: json['email'],
      email: json["email"],
      id: json["id"],
      name: json["name"],
      pid: json["pid"],
      username: json["username"],
      verified: json["verified"],
      isBanned: json["isBanned"],
      slug: json["slug"],
      hasInterests: json["hasInterests"],
      authProvider: json["authProvider"],
      ipAddress: json["ipAddress"],
      twoFactorPassed: json["twoFactorPassed"],
      walletAddress: json["walletAddress"],
      bragWalletBalance: json["bragWalletBalance"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "id": id,
      "name": name,
      "pid": pid,
      "username": username,
      "verified": verified,
      "isBanned": isBanned,
      "slug": slug,
      "hasInterests": hasInterests,
      "authProvider": authProvider,
      "ipAddress": ipAddress,
      "twoFactorPassed": twoFactorPassed,
      "walletAddress": walletAddress,
      "bragWalletBalance": bragWalletBalance,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  factory UserModel.empty() {
    return UserModel(
      email: "",
      id: 0,
      name: "",
      pid: "",
      username: "",
      verified: true,
      isBanned: 0,
      slug: "",
      hasInterests: 0,
      authProvider: "",
      ipAddress: "",
      twoFactorPassed: 0,
      walletAddress: "",
      bragWalletBalance: "",
      createdAt: "",
      updatedAt: "",
    );
  }

  factory UserModel.createFromLogin(Map json) {
    return UserModel(
      email: json["email"] ?? "",
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      pid: "",
      username: "",
      verified: true,
      isBanned: 0,
      slug: "",
      hasInterests: 0,
      authProvider: "",
      ipAddress: "",
      twoFactorPassed: 0,
      walletAddress: "",
      bragWalletBalance: "",
      createdAt: "",
      updatedAt: "",
    );
  }
}
