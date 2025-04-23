import 'package:signalwavex/features/authentication/domain/entities/kyc_enitity.dart';

class KycModel extends KycEntity {
  const KycModel({
    required super.firstName,
    required super.lastName,
    required super.country,
    required super.idType,
    required super.idNumber,
  });

  factory KycModel.fromJson(Map<String, dynamic> json) {
    return KycModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      country: json['country'] ?? '',
      idType: json['id_type'] ?? '',
      idNumber: json['id_number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'country': country,
      'id_type': idType,
      'id_number': idNumber,
    };
  }
}
