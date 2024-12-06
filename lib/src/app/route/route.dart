
import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/app/route/route.constants.dart';
import 'package:quotation_calculation/src/core/views/splash.screen.dart';
import 'package:quotation_calculation/src/core/views/unknown.screen.dart';
import 'package:quotation_calculation/src/features/home/views/home.screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    debugPrint("Navigating to ${settings.name}");
    switch (settings.name) {
      case RouteConstants.splashScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteConstants.splashScreen),
          builder: (context) {
            return const SplashScreen();
          },
        );

      case RouteConstants.homeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteConstants.homeScreen),
          builder: (context) {
            return const HomeScreen();
          },
        );
    }

    assert(false, 'Need to implement ${settings.name}');
    return MaterialPageRoute(builder: (_) => const UnknownScreen());
  }
}

class MenuSlideUpRoute<T> extends MaterialPageRoute<T> {
  MenuSlideUpRoute(
      {required super.builder, required RouteSettings super.settings});

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
