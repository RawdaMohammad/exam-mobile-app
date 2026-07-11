import 'package:exam_mobile_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppTheme {
  AppColors appColors;
  AppTheme(this.appColors);

  late ThemeData themeData = ThemeData(
    colorScheme: ColorScheme(
        brightness: appColors.brightness,
        primary: appColors.primaryColor,
        onPrimary: appColors.backgroundColor,
        secondary: appColors.secondaryColor,
        onSecondary: appColors.backgroundColor,
        error: appColors.errorColor,
        onError: appColors.backgroundColor,
        surface: appColors.backgroundColor,
        onSurface: appColors.secondaryColor,
        tertiary: appColors.darkGreyColor,
    ),
   textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: appColors.secondaryColor
      ),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: appColors.placeHolderColor
      ),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: appColors.secondaryColor
      ),
      titleSmall: TextStyle(
         fontSize: 16,
         fontWeight: FontWeight.w500,
         color: appColors.secondaryColor
      ),
      titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: appColors.secondaryColor
      ),
      titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: appColors.secondaryColor
      ),
     labelMedium: TextStyle(
         fontSize: 12,
         fontWeight: FontWeight.w500,
         color: appColors.secondaryColor
     ),
   )
  );
}