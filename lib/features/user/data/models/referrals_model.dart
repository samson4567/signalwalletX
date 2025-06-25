import 'package:signalwavex/features/user/domain/entities/referrals_entity.dart';

// ReferralsEntity
class ReferralsModel extends ReferralsEntity {
  const ReferralsModel({
    super.userID,
    super.email,
    super.referredOn,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userID,
      "email": email,
      "referred_on": referredOn,
    };
  }

  factory ReferralsModel.fromJson(Map jsonMap) {
    return ReferralsModel(
      // count: jsonMap["count"],
      userID: jsonMap["user_id"],
      email: jsonMap["email"],
      referredOn: jsonMap["referred_on"],
    );
  }
  factory ReferralsModel.fromEntity(ReferralsEntity referralsEntity) {
    return ReferralsModel(
      email: referralsEntity.email,
      referredOn: referralsEntity.referredOn,
      userID: referralsEntity.userID,
    );
  }

  factory ReferralsModel.empty() {
    return const ReferralsModel();
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}





// {
//     "email": "Dada2",
//     "user_id": "Ojo2",
//     "reffered_on": "Nigeria",
//     "id_type": "nin",
//     "id_number": "6654323456754"
// }