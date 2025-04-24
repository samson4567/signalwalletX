import 'package:equatable/equatable.dart';

class KycRequestEntity extends Equatable {
  final String? firstName;
  final String? idNumber;
  final String? country;

  final String? lastName;
  final String? idType;

  const KycRequestEntity({
    required this.lastName,
    required this.firstName,
    required this.idType,
    required this.country,
    required this.idNumber,
  });

  @override
  List<Object?> get props => [
        lastName,
        firstName,
        idType,
        country,
        idNumber,
      ];
}


// {
//     "first_name": "Dada2",
//     "last_name": "Ojo2",
//     "country": "Nigeria",
//     "id_type": "nin",
//     "id_number": "6654323456754"
// }