import 'package:signalwavex/features/user/domain/entities/kyc_request_entity.dart';

// KycRequestEntity

class KycRequestModel extends KycRequestEntity {
  const KycRequestModel({
    super.lastName,
    super.firstName,
    super.idType,
    super.country,
    super.idNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "country": country,
      "id_type": idType,
      "id_number": idNumber
    };
  }

  factory KycRequestModel.fromJson(Map jsonMap) {
    return KycRequestModel(
      firstName: jsonMap["first_name"],
      lastName: jsonMap["last_name"],
      country: jsonMap["country"],
      idType: jsonMap["id_type"],
      idNumber: jsonMap["id_number"],
    );
  }

  factory KycRequestModel.empty() {
    return const KycRequestModel();
  }

  @override
  String toString() {
    return "${super.toString()} ${toJson()}";
  }
}


// {
//     "first_name": "Dada2",
//     "last_name": "Ojo2",
//     "country": "Nigeria",
//     "id_type": "nin",
//     "id_number": "6654323456754"
// }