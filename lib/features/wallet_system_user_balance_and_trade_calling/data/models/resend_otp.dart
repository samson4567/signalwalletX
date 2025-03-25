import 'package:signalwavex/features/authentication/domain/entities/resend_otp.dart';

class ResendOtpModel extends ResendOtpEntity {
  const ResendOtpModel({
    required super.email,
    required super.otp,
  });

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) {
    return ResendOtpModel(
      email: json['email'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}
