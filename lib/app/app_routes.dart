import 'package:flutter/material.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/ui/screens/sign_in_screen.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/ui/screens/splash_screen.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/ui/screen/main_bottom_nav_bar_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    late Widget route;
    if (settings.name == SplashScreen.name) {
      route = const SplashScreen();
    } else if (settings.name == SignInScreen.name) {
      route = const SignInScreen();
    } else if (settings.name == MainBottomNavBarScreen.name) {
      route = const MainBottomNavBarScreen();
    }

    return MaterialPageRoute(
      builder: (context) {
        return route;
      },
    );
  }
}
