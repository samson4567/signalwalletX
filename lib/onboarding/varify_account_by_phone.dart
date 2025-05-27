import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/core/services/phone_number_verifier.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';

import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:signalwavex/feed/Features-UI/current_order_page.dart';
import 'package:signalwavex/languages.dart';
import 'package:signalwavex/router/api_route.dart';

class VarifyAccountByPhone extends StatefulWidget {
  // final PhoneNumberVerifier phoneNumberVerifier;

  const VarifyAccountByPhone({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VarifyAccountByPhoneState createState() => _VarifyAccountByPhoneState();
}

class _VarifyAccountByPhoneState extends State<VarifyAccountByPhone> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  bool isVerifying = false;
  bool isResending = false;
  int resendTimer = 6;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && resendTimer > 0) {
        setState(() {
          resendTimer--;
        });
        _startResendTimer();
      }
    });
  }

  void _verifyCode() {
    String enteredCode =
        _controllers.map((controller) => controller.text).join();

    if (enteredCode.length < 6) {
      _showDialog(
          'error',
          'Invalid OTP'.toCurrentLanguage(),
          'The OTP you entered is incorrect - kindly try again.'
              .toCurrentLanguage());
      return;
    }

    setState(() {
      isVerifying = true;
    });

    // context.read<AuthBloc>().add(
    //       VerifySignUpPhoneNumberVersionEvent(
    //           phoneNumberVerifier: widget.phoneNumberVerifier,
    //           otp: enteredCode),
    //     );
  }

  void _resendOtp() {
    if (resendTimer > 0) return;

    setState(() {
      isResending = true;
    });

    // context.read<AuthBloc>().add(SendPhoneNumberOTPEvent(
    //     phoneNumber: widget.phoneNumberVerifier.phoneNumberAttribute!));
  }

// PhoneNumberVerifier
  void _showDialog(String type, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                type == 'success'
                    ? 'assets/icons/succeful.png'
                    : 'assets/icons/wrong.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _dialogButton(
                  type == 'success'
                      ? 'Login'.toCurrentLanguage()
                      : 'Try Again'.toCurrentLanguage(), () {
                context.push(MyAppRouteConstant.home);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _dialogButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.yellow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is VerifySignUpPhoneNumberVersionSuccessState) {
              // context.read<AuthBloc>().add(RegisterPhoneNumberAsVerifiedEvent(
              //     phoneNumber:
              //         widget.phoneNumberVerifier.phoneNumberAttribute!));
              setState(() => isVerifying = false);
              _showDialog(
                  'success',
                  'You are all set'.toCurrentLanguage(),
                  'Your account has been verified successfully.'
                      .toCurrentLanguage());
              // RegisterPhoneNumberAsVerifiedEvent
            } else if (state is VerifySignUpPhoneNumberVersionErrorState) {
              setState(() => isVerifying = false);
              _showDialog('error', 'Invalid OTP'.toCurrentLanguage(),
                  'The OTP you entered is incorrect.'.toCurrentLanguage());
            } else if (state is SendPhoneNumberOTPSuccessState) {
              setState(() {
                isResending = false;
                resendTimer = 60; // Reset timer
                _startResendTimer();
              });
              _showDialog('success', 'OTP Resent'.toCurrentLanguage(),
                  'A new OTP has been sent to your email.'.toCurrentLanguage());
            } else if (state is SendPhoneNumberOTPErrorState) {
              setState(() => isResending = false);
              _showDialog(
                  'error',
                  'Resend Failed'.toCurrentLanguage(),
                  'Unable to resend OTP. Please try again.'
                      .toCurrentLanguage());
            }
          },
          child: Column(
            children: [
              Image.asset(
                'assets/images/sign.png',
                width: 200,
                height: 129,
              ),
              Container(
                width: 404,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D0D0D),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF242424), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter your phone number code'.toCurrentLanguage(),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We have sent a code to your phone number'
                          .toCurrentLanguage(),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 48,
                          height: 48,
                          child: TextField(
                            controller: _controllers[index],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: const Color(0xFF333333),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                            ),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: isVerifying ? null : _verifyCode,
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorConstants.numyelcolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: isVerifying
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text('Verify'.toCurrentLanguage(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _resendOtp,
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(resendTimer > 30
                            ? '${"Resend OTP in".toCurrentLanguage()} $resendTimer ${"seconds".toCurrentLanguage()}'
                            : 'Resend OTP'.toCurrentLanguage()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
