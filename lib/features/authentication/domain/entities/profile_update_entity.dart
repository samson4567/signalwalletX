import 'package:equatable/equatable.dart';

class ProfileUpdateEntity extends Equatable {
  final int id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? profilePicture;

  const ProfileUpdateEntity({
    required this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [id, name, email, phoneNumber, profilePicture];
}
