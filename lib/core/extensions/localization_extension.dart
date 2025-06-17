import 'package:flutter/material.dart';
import 'package:telemedicine_platform_for_remote_areas/l10n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get localization {
    return AppLocalizations.of(this)!;
  }
}