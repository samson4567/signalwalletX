import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/core/di/injector.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_bloc.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => getItInstance<AuthBloc>()), // Inject AuthBloc
        BlocProvider(create: (_) => getItInstance<AppBloc>()), // Inject AppBloc
        BlocProvider(
            create: (_) => getItInstance<
                WalletSystemUserBalanceAndTradeCallingBloc>()), // Inject WalletSystemUserBalanceAndTradeCallingBloc
        BlocProvider(
            create: (_) =>
                getItInstance<TradingSystemBloc>()), // Inject TradingSystemBloc
        BlocProvider(
            create: (_) =>
                getItInstance<UserBloc>()), // Inject TradingSystemBloc
      ],
      child: ScreenUtilInit(
        designSize: const Size(440, 956),
        builder: (context, child) => MaterialApp.router(
          theme: ThemeData.from(
            colorScheme: const ColorScheme.dark(
              primary: ColorConstants.fancyGreen,
            ),
          ),
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
