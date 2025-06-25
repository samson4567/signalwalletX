import 'package:equatable/equatable.dart';

class ReferralCodeResponseEntity extends Equatable {
  final String? userIdentifier;
  final String? referralLink;

  const ReferralCodeResponseEntity({
    required this.referralLink,
    required this.userIdentifier,
  });

  @override
  List<Object?> get props => [
        referralLink,
        userIdentifier,
      ];
}


// {
//     "first_name": "Dada2",
//     "last_name": "Ojo2",
//     "country": "Nigeria",
//     "id_type": "nin",
//     "id_number": "6654323456754"
// }