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
import 'package:signalwavex/router/api_route.dart';

// SignUpScreen widget for the sign-up page
class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = 612 / screenHeight;
    final containerWidth = 394 / screenWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is NewUserSignUpSuccessState) {
              // Navigate to the verify email screen on success
              context.push(MyAppRouteConstant.verifyEmail,
                  extra: {'email': emailController.text});
            } else if (state is NewUserSignUpErrorState) {
              // Show an error message if sign-up fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                child: Image.asset(
                  'assets/images/sign.png',
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.1,
                  fit: BoxFit.contain,
                ),
              ),
              FancyContainer(
                height: screenHeight * containerHeight,
                width: screenWidth * containerWidth,
                border: Border.all(color: ColorConstants.primaryGrayColor),
                borderRadius: BorderRadius.circular(20.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(screenHeight),
                    _buildSubtitle(screenHeight),
                    _buildEmailField(screenHeight),
                    _buildPasswordField(screenHeight),
                    _buildConfirmPassword(screenHeight),
                    _buildRememberMe(screenHeight),
                    _buildCreateAccountButton(screenHeight),
                    _buildDividerWithOr(screenHeight),
                    _buildGoogleSignInButton(screenHeight),
                    _buildLoginRow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the title section at the top of the login form
  Widget _buildTitle(double screenHeight) {
    return Center(
      child: Text(
        'Create your account',
        textAlign: TextAlign.center,
        style: TextStyles.title.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildSubtitle(double screenHeight) {
    return Center(
      child: Text(
        'Fill the fields below to create your account',
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
        label: 'Email',
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
        label: 'Password',
        hintText: 'Enter your password',
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

  Widget _buildConfirmPassword(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: TextFormFieldWithCustomStyles(
        controller: confirmPasswordController,
        label: 'Confirm Password',
        hintText: 'Enter your password',
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

  Widget _buildRememberMe(double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenHeight * 0.004,
      ),
      child: Row(
        children: [
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                activeColor: Colors.yellow,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value ?? false;
                  });
                },
              ),
              Text(
                'Remember me for 30 days',
                style: TextStyles.bodyText.copyWith(color: Colors.white),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              // Handle forgot password
            },
            child: Text(
              'Forgot password?',
              style: TextStyles.bodyText.copyWith(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  // Create Account button
  Widget _buildCreateAccountButton(double screenHeight) {
    return SizedBox(
      width: double.infinity,
      child: FancyContainer(
        height: 50.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.yellow,
        onTap: () {
          context.read<AuthBloc>().add(
                NewUserSignUpEvent(
                  email: emailController.text,
                  password: passwordController.text,
                  confirmPassword: confirmPasswordController.text,
                ),
              );
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is NewUserSignUpLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              );
            }
            return Center(
              child: Text(
                'Create Account',
                style: TextStyles.normaltext
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDividerWithOr(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.02),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.white.withOpacity(0.5))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'or',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          ),
          Expanded(child: Divider(color: Colors.white.withOpacity(0.5))),
        ],
      ),
    );
  }

  // Google Sign-In button
  Widget _buildGoogleSignInButton(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.02),
      child: SizedBox(
        height: screenHeight * 0.06,
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            // Handle Google sign-in action
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/google.png',
                width: 24.0,
                height: 24.0,
              ),
              const SizedBox(width: 10.0),
              const Text(
                'Continue with Google',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Login navigation row
  Widget _buildLoginRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Already have an account?',
            style: TextStyle(color: Colors.white),
          ),
          TextButton(
            onPressed: () {
              context.push(MyAppRouteConstant.signupscreen);
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
