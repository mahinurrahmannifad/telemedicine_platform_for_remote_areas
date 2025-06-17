import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/app/app_colors.dart';
import 'package:telemedicine_platform_for_remote_areas/app/app_routes.dart';
import 'package:telemedicine_platform_for_remote_areas/app/controller_binder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:telemedicine_platform_for_remote_areas/l10n/app_localizations.dart';

class TelemedicinePlatformForRemoteAreas extends StatefulWidget {
  const TelemedicinePlatformForRemoteAreas({super.key});

  @override
  State<TelemedicinePlatformForRemoteAreas> createState() =>
      _TelemedicinePlatformForRemoteAreasState();
}

class _TelemedicinePlatformForRemoteAreasState
    extends State<TelemedicinePlatformForRemoteAreas> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.inputDecorationThemeColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.inputDecorationThemeColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.inputDecorationThemeColor),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: Colors.white,
            backgroundColor: AppColors.themeColor
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white
        ),
      ),

      localizationsDelegates: const[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('bn')],
      initialBinding: ControllerBinder(),
    );
  }
}
