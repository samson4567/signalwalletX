import 'package:flutter/material.dart';
import 'package:signalwavex/component/color.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  bool isVerifying = false;
  int resendTimer = 6;
  final String correctCode = "123456";

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
      _showDialog('error');
      return;
    }

    setState(() {
      isVerifying = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isVerifying = false;
      });
      _showDialog(enteredCode == correctCode ? 'success' : 'error');
    });
  }

  void _showDialog(String type) {
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
                type == 'success' ? 'You are all set' : 'Invalid OTP',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                type == 'success'
                    ? 'Your account has been created successfully.'
                    : 'The OTP you entered is incorrect - kindly try again.',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _dialogButton(type == 'success' ? 'Login' : 'Try Again', () {
                Navigator.of(context).pop();
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
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [],
        ),
        centerTitle: true,
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
                  const Text(
                    'Enter your email code',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We have sent a code to your email',
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.blue),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
