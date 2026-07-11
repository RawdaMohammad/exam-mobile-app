import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

abstract class AppColors {
  // Primary
  MaterialColor get primaryColor;

  // Neutral
  MaterialColor get secondaryColor;

  // Basic Colors
  Color get whiteColor;
  Color get blackColor;
  Color get darkGreyColor;
  Color get placeHolderColor;

  // Status Colors
  Color get successColor;
  Color get errorColor;

  // Background Colors
  Color get backgroundColor;
  Color get successBackground;
  Color get errorBackground;
  Color get disabledColor;

  Brightness get brightness;
}
@Injectable(as: AppColors)
class LightThemeColors extends AppColors {
  // Primary Blue
  @override
  MaterialColor get primaryColor => const MaterialColor(
    0xFF02369C,
    <int, Color>{
      50: Color(0xFFCCD7EB),
      100: Color(0xFFABBCDE),
      200: Color(0xFF819BCE),
      300: Color(0xFF5679BD),
      400: Color(0xFF2C58AD),
      500: Color(0xFF02369C),
      600: Color(0xFF022D82),
      700: Color(0xFF012468),
      800: Color(0xFF011B4E),
      900: Color(0xFF011234),
    },
  );

  // Neutral / Black Shades
  @override
  MaterialColor get secondaryColor => const MaterialColor(
    0xFF0F0F0F,
    <int, Color>{
      50: Color(0xFFCFCFCF),
      100: Color(0xFFAFAFAF),
      200: Color(0xFF878787),
      300: Color(0xFF5F5F5F),
      400: Color(0xFF373737),
      500: Color(0xFF0F0F0F),
      600: Color(0xFF0D0D0D),
      700: Color(0xFF0A0A0A),
      800: Color(0xFF080808),
      900: Color(0xFF050505),
    },
  );

  // Basic Colors
  @override
  Color get whiteColor => const Color(0xFFFFFFFF);

  @override
  Color get blackColor => const Color(0xFF0F0F0F);

  @override
  Color get darkGreyColor => const Color(0xFF535353);

  @override
  Color get placeHolderColor => const Color(0xFFA6A6A6);

  // Status Colors
  @override
  Color get successColor => const Color(0xFF10D410);

  @override
  Color get errorColor => const Color(0xFFD80D0D);

  // Background Colors
  @override
  Color get backgroundColor => const Color(0xFFF4F6FA);

  @override
  Color get successBackground => const Color(0xFFC5F6C5);

  @override
  Color get errorBackground => const Color(0xFFF8CACA);

  @override
  Color get disabledColor => const Color(0xFF878787);

  @override
  Brightness get brightness => Brightness.light;
}

class DarkThemeColors extends AppColors{
  @override
  // TODO: implement backgroundColor
  Color get backgroundColor => throw UnimplementedError();

  @override
  // TODO: implement blackColor
  Color get blackColor => throw UnimplementedError();

  @override
  // TODO: implement brightness
  Brightness get brightness => throw UnimplementedError();

  @override
  // TODO: implement darkGreyColor
  Color get darkGreyColor => throw UnimplementedError();

  @override
  Color get placeHolderColor => throw UnimplementedError();

  @override
  // TODO: implement disabledColor
  Color get disabledColor => throw UnimplementedError();

  @override
  // TODO: implement errorBackground
  Color get errorBackground => throw UnimplementedError();

  @override
  // TODO: implement errorColor
  Color get errorColor => throw UnimplementedError();

  @override
  // TODO: implement primaryColor
  MaterialColor get primaryColor => throw UnimplementedError();

  @override
  // TODO: implement secondaryColor
  MaterialColor get secondaryColor => throw UnimplementedError();

  @override
  // TODO: implement successBackground
  Color get successBackground => throw UnimplementedError();

  @override
  // TODO: implement successColor
  Color get successColor => throw UnimplementedError();

  @override
  // TODO: implement whiteColor
  Color get whiteColor => throw UnimplementedError();

}