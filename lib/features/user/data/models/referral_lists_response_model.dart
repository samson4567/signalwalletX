import 'package:equatable/equatable.dart';
import 'package:signalwavex/features/user/domain/entities/referral_lists_response_entity.dart';

// ReferralListsResponseEntity
class ReferralListsResponseModel extends ReferralListsResponseEntity {
  const ReferralListsResponseModel({
    super.count,
    super.referrals,
  });

  Map<String, dynamic> toJson() {
    return {
      "count": count,
      "referrals": referrals,
    };
  }

  factory ReferralListsResponseModel.fromJson(Map jsonMap) {
    return ReferralListsResponseModel(
      count: jsonMap["count"],
      referrals: [...(jsonMap["referrals"] ?? [])],
    );
  }
  factory ReferralListsResponseModel.fromEntity(
      ReferralListsResponseEntity referralListsResponseEntity) {
    return ReferralListsResponseModel(
      count: referralListsResponseEntity.count,
      referrals: referralListsResponseEntity.referrals,
    );
  }

  factory ReferralListsResponseModel.empty() {
    return const ReferralListsResponseModel();
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}



// {
//     "first_name": "Dada2",
//     "last_name": "Ojo2",
//     "country": "Nigeria",
//     "id_type": "nin",
//     "id_number": "6654323456754"
// }