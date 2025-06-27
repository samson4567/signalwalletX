import 'package:signalwavex/features/user/domain/entities/referral_code_response_entity.dart';

// ReferralCodeResponseEntity
class ReferralCodeResponseModel extends ReferralCodeResponseEntity {
  const ReferralCodeResponseModel({
    super.referralLink,
    super.userIdentifier,
  });

  Map<String, dynamic> toJson() {
    return {
      "referral_link": referralLink,
      "user_identifier": userIdentifier,
    };
  }

  factory ReferralCodeResponseModel.fromJson(Map jsonMap) {
    return ReferralCodeResponseModel(
      referralLink: jsonMap["referral_link"],
      userIdentifier: jsonMap["user_identifier"],
    );
  }
  factory ReferralCodeResponseModel.fromEntity(
      ReferralCodeResponseEntity referralCodeResponseEntity) {
    return ReferralCodeResponseModel(
      referralLink: referralCodeResponseEntity.referralLink,
      userIdentifier: referralCodeResponseEntity.userIdentifier,
    );
  }

  factory ReferralCodeResponseModel.empty() {
    return const ReferralCodeResponseModel();
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