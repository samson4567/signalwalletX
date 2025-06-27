import 'package:equatable/equatable.dart';

class ReferralListsResponseEntity extends Equatable {
  final int? count;
  final List<Map>? referrals;

  const ReferralListsResponseEntity({
    required this.count,
    required this.referrals,
  });

  @override
  List<Object?> get props => [
        count,
        referrals,
      ];
}


// {
//     "first_name": "Dada2",
//     "last_name": "Ojo2",
//     "country": "Nigeria",
//     "id_type": "nin",
//     "id_number": "6654323456754"
// }