import 'package:go_router/go_router.dart';
import 'package:signalwavex/feed/feed.dart';
import 'package:signalwavex/feed/homepage.dart';
import 'package:signalwavex/onboarding/create_account.dart';
import 'package:signalwavex/onboarding/login_screen.dart';
import 'package:signalwavex/onboarding/varify_account.dart';
import 'package:signalwavex/router/api_route.dart';
import 'package:signalwavex/testScreen/test_screen.dart';
import 'package:signalwavex/tradesection/convert.dart';

import 'package:signalwavex/tradesection/deposit.dart';
import 'package:signalwavex/tradesection/trade.dart';
import 'package:signalwavex/tradesection/transfer.dart';
import '../onboarding/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: MyAppRouteConstant.testScreen,
    routes: [
      GoRoute(
        name: MyAppRouteConstant.splashScreen,
        path: MyAppRouteConstant.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: MyAppRouteConstant.testScreen,
        path: MyAppRouteConstant.testScreen,
        builder: (context, state) => const TestScreen(),
      ),
      GoRoute(
        name: MyAppRouteConstant.signupscreen,
        path: MyAppRouteConstant.signupscreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: MyAppRouteConstant.createAccount,
        path: MyAppRouteConstant.createAccount,
        builder: (context, state) => const CreateAccount(),
      ),
      GoRoute(
        name: MyAppRouteConstant.verifyEmail,
        path: MyAppRouteConstant.verifyEmail,
        builder: (context, state) => const VerifyEmail(),
      ),
      GoRoute(
        name: MyAppRouteConstant.feedPage,
        path: MyAppRouteConstant.feedPage,
        builder: (context, state) => const FeedPage(),
      ),
      GoRoute(
        name: MyAppRouteConstant.trade,
        path: MyAppRouteConstant.trade,
        builder: (context, state) => TradePage(),
      ),
      GoRoute(
        name: MyAppRouteConstant.convert,
        path: MyAppRouteConstant.convert,
        builder: (context, state) => const Convert(),
      ),
      GoRoute(
        name: MyAppRouteConstant.deposit,
        path: MyAppRouteConstant.deposit,
        builder: (context, state) => DepositPage(),
      ),
      GoRoute(
        name: MyAppRouteConstant.transfer,
        path: MyAppRouteConstant.transfer,
        builder: (context, state) => TransferPage(),
      ),
    ],
  );
}
