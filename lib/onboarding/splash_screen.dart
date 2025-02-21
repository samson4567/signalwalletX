import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signalwavex/router/api_route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      context.go(MyAppRouteConstant.signupscreen);
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/images/sign.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
