import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sludoko/core/route/routes.dart';
import 'package:sludoko/core/widgets/utils/shared_prefs.dart';
import 'package:sludoko/features/home/controller/game_controller.dart';
import 'package:sludoko/features/home/home_screen.dart';
import 'package:sludoko/features/main/main_screen.dart';
import 'package:sludoko/features/premium/premium_screen.dart';
import 'package:sludoko/features/rules/rules_screen.dart';
import 'package:sludoko/features/settings/settings_screen.dart';
import 'package:sludoko/features/splash/splash_screen.dart';
import 'package:sludoko/service_locator.dart';

class AppRoute {
  factory AppRoute() => AppRoute._internal();

  AppRoute._internal();
  final main = Get.nestedKey(0);
  final nested = Get.nestedKey(1);

  Bindings? initialBinding() {
    return BindingsBuilder(() {
      locator<SharedPrefs>();
    });
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLink.splash:
        return pageRouteBuilder(page: const SplashScreen());

      case RouteLink.main:
        return pageRouteBuilder(page: const MainScreen());

      case RouteLink.home:
        {
          final args = settings.arguments as Map<String, dynamic>;
          final type = args['type'] as Difficulty;
          final canCnt = args['continue'] as bool;

          return pageRouteBuilder(
            page: HomeScreen(type: type, canContinue: canCnt),
          );
        }

      case RouteLink.rules:
        return pageRouteBuilder(page: RulesScreen());

      case RouteLink.settings:
        return pageRouteBuilder(page: SettingsScreen());

      case RouteLink.premium:
        return pageRouteBuilder(page: PremiumScreen());

      default:
        return pageRouteBuilder(
          page: Scaffold(body: Container(color: Colors.red)),
        );
    }
  }

  GetPageRoute pageRouteBuilder({
    required Widget page,
    RouteSettings? settings,
  }) => GetPageRoute(
    transitionDuration: Duration.zero,
    page: () => page,
    settings: settings,
  );
}
