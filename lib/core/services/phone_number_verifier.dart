import 'package:flutter_otp/flutter_otp.dart';

class PhoneNumberVerifier {
  // EmailOTP myauth = EmailOTP();
  FlutterOtp otp = FlutterOtp();
  String? phoneNumberAttribute;
  //Pass phone number as String
  Future<String> sendOTP(String phoneNumber) async {
    // Add your function code here!
    phoneNumberAttribute = phoneNumber;
    otp.sendOtp(phoneNumber);

    return "OTP has been sent";
  }

  Future<bool> confirmOTP(int? otpInputedByUser) async {
    return otp.resultChecker(otpInputedByUser as int);
  }
}
