import 'package:equatable/equatable.dart';

class KycEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String country;
  final String idType;
  final String idNumber;

  const KycEntity({
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.idType,
    required this.idNumber,
  });

  @override
  List<Object> get props => [firstName, lastName, country, idType, idNumber];
}
