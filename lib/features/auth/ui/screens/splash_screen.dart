import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/app/app_colors.dart';
import 'package:telemedicine_platform_for_remote_areas/app/app_config.dart';
import 'package:telemedicine_platform_for_remote_areas/core/extensions/localization_extension.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/ui/controllers/auth_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/ui/widgets/app_logo.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/ui/screen/main_bottom_nav_bar_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await Get.find<AuthController>().getUserData();
    Navigator.pushReplacementNamed(context, MainBottomNavBarScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              const AppLogo(),
              const Spacer(),
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                  '${context.localization.version} ${AppConfigs.currentAppVersion}')
            ],
          ),
        ),
      ),
    );
  }

}
