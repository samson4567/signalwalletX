import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';

import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:signalwavex/feed/Features-UI/current_order_page.dart';
import 'package:signalwavex/languages.dart';
import 'package:signalwavex/router/api_route.dart';

class VerifyEmail extends StatefulWidget {
  final String email;

  const VerifyEmail({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
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
          toCurrentLanguageFunction('Invalid OTP'),
          toCurrentLanguageFunction(
              'The OTP you entered is incorrect - kindly try again.'));
      return;
    }

    setState(() {
      isVerifying = true;
    });

    context.read<AuthBloc>().add(
          VerifyNewSignUpEmailEvent(email: widget.email, otp: enteredCode),
        );
  }

  void _resendOtp() {
    if (resendTimer > 0) return;

    setState(() {
      isResending = true;
    });

    context.read<AuthBloc>().add(ResendOtpEvent(email: widget.email));
  }

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
                      ? toCurrentLanguageFunction('Login')
                      : toCurrentLanguageFunction('Try Again'), () {
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
            if (state is VerifyNewSignUpEmailSuccessState) {
              setState(() => isVerifying = false);
              _showDialog(
                'success',
                toCurrentLanguageFunction('You are all set'),
                toCurrentLanguageFunction(
                    'Your account has been verified successfully.'),
              );
            } else if (state is VerifyNewSignUpEmailErrorState) {
              setState(() => isVerifying = false);
              _showDialog(
                  'error',
                  toCurrentLanguageFunction('Invalid OTP'),
                  toCurrentLanguageFunction(
                      'The OTP you entered is incorrect.'));
            } else if (state is ResendOtpSuccessState) {
              setState(() {
                isResending = false;
                resendTimer = 60; // Reset timer
                _startResendTimer();
              });
              _showDialog(
                  'success',
                  toCurrentLanguageFunction('OTP Resent'),
                  toCurrentLanguageFunction(
                      'A new OTP has been sent to your email.'));
            } else if (state is ResendOtpErrorState) {
              setState(() => isResending = false);
              _showDialog(
                  'error',
                  toCurrentLanguageFunction('Resend Failed'),
                  toCurrentLanguageFunction(
                      'Unable to resend OTP. Please try again.'));
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
                      toCurrentLanguageFunction('Enter your email code'),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      toCurrentLanguageFunction(
                          'We have sent a code to your email'),
                      style: TextStyle(fontSize: 14, color: Colors.grey),
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
                            : Text(toCurrentLanguageFunction('Verify'),
                                style: TextStyle(
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
                            ? '${toCurrentLanguageFunction("Resend OTP in")} $resendTimer ${toCurrentLanguageFunction("seconds")}'
                            : toCurrentLanguageFunction('Resend OTP')),
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
