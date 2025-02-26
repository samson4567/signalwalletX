import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/router/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
    );
  }
}
