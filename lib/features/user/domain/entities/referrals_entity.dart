import 'package:equatable/equatable.dart';

class ReferralsEntity extends Equatable {
  final String? email;
  final String? userID;
  final String? referredOn;

  const ReferralsEntity({
    required this.userID,
    required this.email,
    required this.referredOn,
  });

  @override
  List<Object?> get props => [
        userID,
        email,
        referredOn,
      ];
}


// {
//     "email": "Dada2",
//     "user_id": "Ojo2",
//     "reffered_on": "Nigeria",
//     "id_type": "nin",
//     "id_number": "6654323456754"
// }