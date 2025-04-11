import 'package:signalwavex/features/authentication/domain/entities/profile_update_entity.dart';

class ProfileUpdateModel extends ProfileUpdateEntity {
  const ProfileUpdateModel({
    required super.id,
    super.name,
    super.email,
    super.phoneNumber,
    super.profilePicture,
  });

  factory ProfileUpdateModel.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      profilePicture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'profile_picture': profilePicture,
    };
  }
}
