// export '';

// import 'package:signalwavex/features/user/domain/entities/user_entity.dart';
// import 'package:uuid/uuid.dart';


// class UserModel extends UserEntity {
//   UserModel({
//     super.email,
//     super.id,
//     super.name,
//     super.uid,
//     super.wallets,
//     super.role,
//     super.isVerified,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       email: json["email"],
//       id: json["id"],
//       name: json["name"],
//       uid: json["uid"],
//       wallets: json["wallets"],
//       role: json["role"],
//       isVerified: json["is_verified"],
//     );
//     // (
//     //   // email: json['email'],
//     //   email: json["email"],
//     //   id: json["id"],
//     //   name: json["name"],

//     // );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "email": email,
//       "id": id,
//       "name": name,
//       "uid": uid,
//       "wallets": wallets,
//       "role": role,
//       "is_verified": isVerified,
//     };
//   }

//   factory UserModel.empty() {
//     return UserModel(
//       email: "dummers@gmail.com",
//       id: 1311,
//       name: "dummer joe",
//       uid: Uuid().v4(),
//       wallets: [],
//       role: "trader",
//       isVerified: true,
//     );
//     // (
//     //   email: "",
//     //   id: 0,
//     //   name: "",

//     // );
//   }

  // factory UserModel.createFromLogin(Map json) {
  //   return UserModel(
  //     email: json["email"] ?? "",
  //     id: json["id"] ?? 0,
  //     name: json["name"] ?? "",
  //     uid: json["uid"] ?? "",
  //     role: json["role"] ?? "",
  //   );
  // }
// }
