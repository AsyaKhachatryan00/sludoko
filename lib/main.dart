import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sludoko/core/config/theme/app_theme.dart';
import 'package:sludoko/core/route/app_navigations.dart';
import 'package:sludoko/service_locator.dart';
import 'core/route/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.standard,
      navigatorKey: AppRoute().main,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteLink.splash,
      title: 'Sludoko: Color Sudoku Game',
      onGenerateRoute: AppRoute().generateRoute,
      initialBinding: AppRoute().initialBinding(),
      builder: (context, child) {
        ErrorWidget.builder = (errorDetails) {
          return const Center(
            child: Text(
              "An error occurred. Please try again later",
              style: TextStyle(fontSize: 14),
            ),
          );
        };
        return child ?? SizedBox();
      },
    );
  }
}
