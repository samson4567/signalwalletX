import 'package:go_router/go_router.dart';
import 'package:signalwavex/feed/Features-UI/current_order_page.dart';
import 'package:signalwavex/feed/asset.dart';
import 'package:signalwavex/feed/feed.dart';
import 'package:signalwavex/feed/homepage.dart';
import 'package:signalwavex/feed/market.dart';
import 'package:signalwavex/feed/ppertual.dart';
import 'package:signalwavex/feed/widthraw.dart';
import 'package:signalwavex/onboarding/create_account.dart';
import 'package:signalwavex/onboarding/forget_passoword.dart';
import 'package:signalwavex/onboarding/forget_passoword_otp.dart';
import 'package:signalwavex/onboarding/login_screen.dart';
import 'package:signalwavex/onboarding/phone_auth_webview.dart';
import 'package:signalwavex/onboarding/set_newpassword.dart';
import 'package:signalwavex/onboarding/varify_account.dart';
import 'package:signalwavex/router/api_route.dart';
import 'package:signalwavex/settings/settings.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/test_screen.dart';
import 'package:signalwavex/tradesection/convert.dart';
import 'package:signalwavex/tradesection/deposit.dart';
import 'package:signalwavex/tradesection/transfer.dart';
import '../onboarding/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: MyAppRouteConstant.splashScreen,
    // initialLocation: MyAppRouteConstant.testScreen,

    routes: [
      GoRoute(
        name: MyAppRouteConstant.splashScreen,
        path: MyAppRouteConstant.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: MyAppRouteConstant.phoneAuthWebview,
        path: MyAppRouteConstant.phoneAuthWebview,
        builder: (context, state) => PhoneAuthWebview(
          registrationUrl: (state.extra as Map)['registrationUrl'],
          successRedirectUrl: (state.extra as Map)['successRedirectUrl'],
          onfinished: (state.extra as Map)['onfinished'],
        ),
      ),
      // PhoneAuthWebview
      GoRoute(
        name: MyAppRouteConstant.testScreen,
        path: MyAppRouteConstant.testScreen,
        builder: (context, state) => const TestScreen(),
      ),
      GoRoute(
        name: MyAppRouteConstant.login,
        path: MyAppRouteConstant.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: MyAppRouteConstant.createAccount,
        path: MyAppRouteConstant.createAccount,
        builder: (context, state) => const CreateAccount(),
      ),
      GoRoute(
        name: MyAppRouteConstant.forgetPassowrd,
        path: MyAppRouteConstant.forgetPassowrd,
        builder: (context, state) => const ForgetPassoword(),
      ),
      GoRoute(
        name: MyAppRouteConstant.forgetPassowrdOTP,
        path: MyAppRouteConstant.forgetPassowrdOTP,
        builder: (context, state) {
          final extra = state.extra;
          final email = (extra is Map && extra['email'] is String)
              ? extra['email'] as String
              : '';

          return VerifyForgetPasswordOtp(email: email);
        },
      ),
      GoRoute(
        name: MyAppRouteConstant.verifyEmail,
        path: MyAppRouteConstant.verifyEmail,
        builder: (context, state) =>
            VerifyEmail(email: (state.extra as Map)['email']),
      ),
      // GoRoute(
      //   name: MyAppRouteConstant.varifyAccountByPhone,
      //   path: MyAppRouteConstant.varifyAccountByPhone,
      //   builder: (context, state) => VarifyAccountByPhone(
      //       phoneNumberVerifier: (state.extra as Map)['phoneNumberVerifier']),
      // ),

      GoRoute(
          name: MyAppRouteConstant.setNewpassoword,
          path: MyAppRouteConstant.setNewpassoword,
          builder: (context, state) => const SetNewPassword()),
      GoRoute(
        name: MyAppRouteConstant.feedPage,
        path: MyAppRouteConstant.feedPage,
        builder: (context, state) => const FeedPage(),
      ),
      GoRoute(
        name: MyAppRouteConstant.trade,
        path: MyAppRouteConstant.trade,
        builder: (context, state) => const TransferPage(),
      ),
      GoRoute(
        name: MyAppRouteConstant.convert,
        path: MyAppRouteConstant.convert,
        builder: (context, state) => const Convert(),
      ),
      GoRoute(
        name: MyAppRouteConstant.deposit,
        path: MyAppRouteConstant.deposit,
        builder: (context, state) => const DepositPage(),
      ),
      GoRoute(
        name: MyAppRouteConstant.transfer,
        path: MyAppRouteConstant.transfer,
        builder: (context, state) => const TransferPage(),
      ),
      GoRoute(
        name: MyAppRouteConstant.withdraw,
        path: MyAppRouteConstant.withdraw,
        builder: (context, state) => const Withdraw(),
      ),
      GoRoute(
        name: MyAppRouteConstant.settings,
        path: MyAppRouteConstant.settings,
        builder: (context, state) => const Settings(),
      ),
      GoRoute(
        name: MyAppRouteConstant.home,
        path: MyAppRouteConstant.home,
        builder: (context, state) => const Homepage(),
      ),
      GoRoute(
        name: MyAppRouteConstant.market,
        path: MyAppRouteConstant.market,
        builder: (context, state) => const Market(),
      ),
      GoRoute(
        name: MyAppRouteConstant.features,
        path: MyAppRouteConstant.features,
        builder: (context, state) => const FeaturesCurrentOrder(),
      ),
      GoRoute(
        name: MyAppRouteConstant.perpetual,
        path: MyAppRouteConstant.perpetual,
        builder: (context, state) => const PerpetualScreen(),
      ),
      GoRoute(
        name: MyAppRouteConstant.assets,
        path: MyAppRouteConstant.assets,
        builder: (context, state) => const Assets(),
      ),
    ],
  );
}
