import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/core/app_variables.dart';
import 'package:signalwavex/core/di/injector.dart';
import 'package:signalwavex/features/app_bloc/presentation/blocs/auth_bloc/app_bloc.dart';
import 'package:signalwavex/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:signalwavex/features/trading_system/presentation/blocs/auth_bloc/trading_system_bloc.dart';
import 'package:signalwavex/features/user/presentation/blocs/auth_bloc/user_bloc.dart';
import 'package:signalwavex/features/wallet_system_user_balance_and_trade_calling/presentation/blocs/auth_bloc/wallet_system_user_balance_and_trade_calling_bloc.dart';
import 'package:signalwavex/router/router.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InternetConnection internetConnection =
      InternetConnection.createInstance(enableStrictCheck: false);
  StreamSubscription? streamSubscription;
  @override
  void initState() {
    internetConnection.hasInternetAccess.then(
      (value) {
        print("debug_print_internetConnection.hasInternetAccess${value}");
        hasInternet = value;
      },
    );
    streamSubscription = internetConnection.onStatusChange.listen(
      (internetStatus) {
        hasInternet = (internetStatus == InternetStatus.connected);
      },
    );
    super.initState();
  }

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
            create: (_) => getItInstance<UserBloc>()), // Inject UserBloc
        BlocProvider(create: (_) => WebSocketBloc()), // Inject WebSocketBloc
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
