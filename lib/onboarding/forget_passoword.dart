import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc package
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

class ForgetPassoword extends StatefulWidget {
  const ForgetPassoword({super.key});

  @override
  State<ForgetPassoword> createState() => _ForgetPassowordState();
}

class _ForgetPassowordState extends State<ForgetPassoword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = 300 / screenHeight;
    final containerWidth = 394 / screenWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // Listen to success and error states
            if (state is ForgetPasswordErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is ForgetPasswordSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              context.push(
                MyAppRouteConstant.forgetPassowrdOTP,
                extra: {
                  toCurrentLanguageFunction('email'):
                      emailController.text.trim()
                },
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back arrow with reduced vertical padding
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_outlined,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: Center(
                    child: FancyContainer(
                      height: screenHeight * containerHeight,
                      width: screenWidth * containerWidth,
                      border:
                          Border.all(color: ColorConstants.primaryGrayColor),
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
                            _buildSubmitButton(state, screenHeight),
                          ],
                        ),
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

  Widget _buildTitle(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.02),
      child: Center(
        child: Text(
          toCurrentLanguageFunction('Forget Your Password'),
          textAlign: TextAlign.center,
          style: TextStyles.title.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSubtitle(double screenHeight) {
    return Center(
      child: Text(
        toCurrentLanguageFunction(
            'An OTP will be sent to your mail to reset your password'),
        textAlign: TextAlign.center,
        style: TextStyles.subtitle.copyWith(
          color: ColorConstants.primarydeepColor,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildEmailField(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: TextFormFieldWithCustomStyles(
        controller: emailController,
        label: toCurrentLanguageFunction('Email'),
        hintText: toCurrentLanguageFunction('Enter your email'),
        fillColor: Colors.black,
        labelColor: Colors.white,
        hintColor: Colors.white.withOpacity(0.6),
        textColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        suffixImagePath: 'assets/icons/mail.png',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return toCurrentLanguageFunction('Please enter your email');
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSubmitButton(AuthState state, double screenHeight) {
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
              // Trigger the forget password event when the form is valid
              context.read<AuthBloc>().add(
                    ForgetPasswordEvent(email: emailController.text),
                  );
            }
          },
          child: Center(
            child: state is ForgetPasswordLoadingState
                ? const CircularProgressIndicator(
                    color: Colors.black,
                  )
                : Text(
                    toCurrentLanguageFunction('Submit'),
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
