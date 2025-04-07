import 'package:signalwavex/features/authentication/domain/entities/forgetpassoword_entity.dart';

class ForgetPasswordModel extends ForgetPasswordEntity {
  const ForgetPasswordModel({
    required super.email,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
