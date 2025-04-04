import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/fansycontainer.dart';
import 'package:signalwavex/component/textform_filled.dart';
import 'package:signalwavex/component/textstyle.dart';
import 'package:signalwavex/router/api_route.dart';

class SetNewPassoword extends StatefulWidget {
  const SetNewPassoword({super.key});

  @override
  State<SetNewPassoword> createState() => _SetNewPassowordState();
}

class _SetNewPassowordState extends State<SetNewPassoword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = 350 / screenHeight;
    final containerWidth = 394 / screenWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // reduced from 20 to 10
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child:
                    const Icon(Icons.arrow_back_outlined, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.05,
              ),
              child: FancyContainer(
                height: screenHeight * containerHeight,
                width: screenWidth * containerWidth,
                border: Border.all(color: ColorConstants.primaryGrayColor),
                borderRadius: BorderRadius.circular(20.0),
                padding: const EdgeInsets.all(20.0),
                color: Colors.black,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(screenHeight),
                      _buildSubtitle(screenHeight),
                      _buildEmailField(screenHeight),
                      _buildPasswordField(screenHeight),
                      _buildLoginButton(screenHeight),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: Center(
        child: Text(
          'Set new Passoword',
          textAlign: TextAlign.center,
          style: TextStyles.title.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSubtitle(double screenHeight) {
    return Center(
      child: Text(
        'Fill the below to set new passoword',
        textAlign: TextAlign.center,
        style: TextStyles.subtitle
            .copyWith(color: ColorConstants.primarydeepColor),
      ),
    );
  }

  Widget _buildEmailField(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: TextFormFieldWithCustomStyles(
        controller: emailController,
        label: 'Passoword',
        hintText: 'Enter your email',
        fillColor: Colors.black,
        labelColor: Colors.white,
        hintColor: Colors.white.withOpacity(0.6),
        textColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        suffixImagePath: 'assets/icons/mail.png',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: TextFormFieldWithCustomStyles(
        controller: passwordController,
        label: 'Confirm Passpword',
        hintText: 'Confirm Passoword',
        fillColor: Colors.black,
        labelColor: Colors.white,
        hintColor: Colors.white.withOpacity(0.6),
        textColor: Colors.white,
        obscureText: _obscurePassword,
        suffixImagePath: 'assets/icons/eyes.png',
        onSuffixTap: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: SizedBox(
        width: double.infinity,
        child: FancyContainer(
          height: 50.0,
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.yellow,
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              setState(() => _isLoading = true);

              // Simulate login
              await Future.delayed(const Duration(seconds: 2));

              setState(() => _isLoading = false);

              // Fake success login
              if (emailController.text == "user@example.com" &&
                  passwordController.text == "password") {
                context.push(MyAppRouteConstant.feedPage,
                    extra: {'email': emailController.text});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Invalid credentials"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.black)
                : const Text(
                    'Reset Passoword',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
