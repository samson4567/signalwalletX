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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = 630 / screenHeight;
    final containerWidth = 394 / screenWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              context.push(MyAppRouteConstant.feedPage);
            } else if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
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
                      _buildRememberMe(screenHeight),
                      _buildLoginButton(screenHeight),
                      _buildDividerWithOr(screenHeight),
                      _buildGoogleSignInButton(screenHeight),
                      _buildCreateAccountRow()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.05),
      child: Center(
        child: Text(
          'Log Into your account',
          textAlign: TextAlign.center,
          style: TextStyles.title.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSubtitle(double screenHeight) {
    return Center(
      child: Text(
        'Enter your credentials to access your account',
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

  Widget _buildRememberMe(double screenHeight) {
    return Row(
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
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            'Forgot password?',
            style: TextStyles.bodyText.copyWith(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(double screenHeight) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
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
                        LoginEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                }
              },
              child: Center(
                child: state is LoginLoadingState
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'Log into Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Log In button

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

  Widget _buildCreateAccountRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Are you new here?',
            style: TextStyle(color: Colors.white),
          ),
          TextButton(
            onPressed: () {
              // Navigate to sign-up page
            },
            child: GestureDetector(
              onTap: () => context.push(MyAppRouteConstant.createAccount),
              child: const Text(
                'Create account',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
