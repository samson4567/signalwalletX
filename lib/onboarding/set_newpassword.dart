import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/fansycontainer.dart';
import 'package:signalwavex/component/textform_filled.dart';
import 'package:signalwavex/component/textstyle.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:signalwavex/languages.dart';
import 'package:signalwavex/router/api_route.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

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
                      ? 'Continue'.toCurrentLanguage()
                      : 'Try Again'.toCurrentLanguage(), () {
                if (type == 'success') {
                  context.push(MyAppRouteConstant.login);
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = 450 / screenHeight;
    final containerWidth = 394 / screenWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SetNewPasswordSuccessState) {
              _showDialog(
                  'success',
                  'Password Reset Successful'.toCurrentLanguage(),
                  state.message);
            } else if (state is SetNewPasswordErrorState) {
              _showDialog('error', 'Password Reset Failed'.toCurrentLanguage(),
                  state.errorMessage);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
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
                          _buildSubtitle(),
                          _buildEmailField(screenHeight),
                          _buildPasswordField(screenHeight),
                          _buildConfirmPasswordField(screenHeight),
                          _buildSubmitButton(screenHeight, state),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Icon(Icons.arrow_back_outlined, color: Colors.white),
    );
  }

  Widget _buildTitle(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: Center(
        child: Text(
          'Set new Password'.toCurrentLanguage(),
          style: TextStyles.title.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Center(
      child: Text(
        'Fill the below to set new password'.toCurrentLanguage(),
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
        label: 'Email'.toCurrentLanguage(),
        hintText: 'Enter your email'.toCurrentLanguage(),
        fillColor: Colors.black,
        labelColor: Colors.white,
        hintColor: Colors.white.withOpacity(0.6),
        textColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        suffixImagePath: 'assets/icons/mail.png',
        validator: (value) {
          if (value == null || value.isEmpty)
            return 'Please enter your email'.toCurrentLanguage();
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
        label: 'Password'.toCurrentLanguage(),
        hintText: 'Enter your password'.toCurrentLanguage(),
        fillColor: Colors.black,
        labelColor: Colors.white,
        hintColor: Colors.white.withOpacity(0.6),
        textColor: Colors.white,
        obscureText: _obscurePassword,
        suffixImagePath: 'assets/icons/eyes.png',
        onSuffixTap: () {
          setState(() => _obscurePassword = !_obscurePassword);
        },
        validator: (value) {
          if (value == null || value.isEmpty)
            return 'Please enter your password'.toCurrentLanguage();
          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: TextFormFieldWithCustomStyles(
        controller: confirmPasswordController,
        label: 'Confirm Password'.toCurrentLanguage(),
        hintText: 'Confirm password'.toCurrentLanguage(),
        fillColor: Colors.black,
        labelColor: Colors.white,
        hintColor: Colors.white.withOpacity(0.6),
        textColor: Colors.white,
        obscureText: _obscurePassword,
        suffixImagePath: 'assets/icons/eyes.png',
        onSuffixTap: () {
          setState(() => _obscurePassword = !_obscurePassword);
        },
        validator: (value) {
          if (value == null || value.isEmpty)
            return 'Please confirm password'.toCurrentLanguage();
          if (value != passwordController.text)
            return 'Passwords do not match'.toCurrentLanguage();
          return null;
        },
      ),
    );
  }

  Widget _buildSubmitButton(double screenHeight, AuthState state) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: SizedBox(
        width: double.infinity,
        child: FancyContainer(
          height: 50.0,
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.yellow,
          onTap: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthBloc>().add(
                    SetNewPasswordEvent(
                      emailController.text.trim(),
                      passwordController.text,
                      confirmPasswordController.text,
                    ),
                  );
            }
          },
          child: Center(
            child: state is SetNewPasswordLoadingState
                ? const CircularProgressIndicator(color: Colors.black)
                : Text(
                    'Reset Password'.toCurrentLanguage(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}
