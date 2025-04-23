import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:signalwavex/languages.dart';
import 'package:signalwavex/router/api_route.dart';

class VerifyForgetPasswordOtp extends StatefulWidget {
  final String email;

  const VerifyForgetPasswordOtp({super.key, required this.email});

  @override
  _VerifyForgetPasswordOtpState createState() =>
      _VerifyForgetPasswordOtpState();
}

class _VerifyForgetPasswordOtpState extends State<VerifyForgetPasswordOtp> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

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
            .toCurrentLanguage(),
      );
      return;
    }

    setState(() {
      isVerifying = true; // Set to true when verification starts
    });

    BlocProvider.of<AuthBloc>(context)
        .add(OtpVerificationEvent(otp: enteredCode));

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isVerifying = false;
      });

      _showDialog(
        'success',
        'OTP Verified'.toCurrentLanguage(),
        'Your OTP has been verified successfully.'.toCurrentLanguage(),
      );
    });
  }

  void _resendOtp() {
    if (resendTimer > 0) return;

    // Trigger the OTP resend event in BLoC
    BlocProvider.of<AuthBloc>(context).add(ResendOtpEvent(email: widget.email));
    setState(() {
      isResending = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isResending = false;
        resendTimer = 60;
        _startResendTimer();
      });

      _showDialog('success', 'OTP Resent'.toCurrentLanguage(),
          'A new OTP has been sent to your email.'.toCurrentLanguage());
    });
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
                      ? 'Login'.toCurrentLanguage()
                      : 'Try Again'.toCurrentLanguage(), () {
                if (type == 'success') {
                  context.push(MyAppRouteConstant.setNewpassoword);
                } else {
                  Navigator.pop(context);
                }
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

  void _onOtpChanged(String value, int index) {
    // Move to the next focus when the user enters a digit
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }

    // Trigger OTP verification if all fields are filled
    if (_controllers.every((controller) => controller.text.isNotEmpty)) {
      _verifyCode();
    }
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
                    'Enter your email code'.toCurrentLanguage(),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We have sent a code to your email'.toCurrentLanguage(),
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
                          focusNode: _focusNodes[index],
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _onOtpChanged(value, index),
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
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Verify',
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
    );
  }
}
