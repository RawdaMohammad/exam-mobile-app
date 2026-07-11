import 'package:exam_mobile_app/core/constants/storage_keys.dart';
import 'package:exam_mobile_app/core/di/di.dart';
import 'package:exam_mobile_app/core/theme/app_colors.dart';
import 'package:exam_mobile_app/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AppConfigProvider extends ChangeNotifier {

  SharedPreferences sharedPreferences;

  AppConfigProvider(this.sharedPreferences);

  Future<void> changeTheme(ThemeOptions themeOptions) async{
    AppColors appColors = switch(themeOptions){
      ThemeOptions.dark => DarkThemeColors(), // ToDo to be implemented
      ThemeOptions.light => LightThemeColors(),
    };

    if(getIt.isRegistered<AppColors>()){
      getIt.unregister<AppColors>();
    }
    if(getIt.isRegistered<AppTheme>()){
      getIt.unregister<AppTheme>();
    }
    if(getIt.isRegistered<ThemeOptions>()){
      getIt.unregister<ThemeOptions>();
    }

    await sharedPreferences.setString(
      themeKey,
      themeOptions.name,
    );
    getIt.registerSingleton<AppColors>(appColors);
    getIt.registerSingleton<AppTheme>(AppTheme(getIt()));
    getIt.registerSingleton<ThemeOptions>(themeOptions);
    notifyListeners();
  }

  Future<void> setDefaultTheme() async{
    var currentTheme = ThemeOptions.stringToTheme(sharedPreferences.getString(themeKey)?? "");
    await changeTheme(currentTheme);
  }

  Future<void> saveLanguage(Locale locale) async {
    await sharedPreferences.setString(
      languageKey,
      '${locale.languageCode}_${locale.countryCode}',
    );
  }

  Locale getCurrentLocale() {
    final localeString =
        sharedPreferences.getString(languageKey) ?? 'en_US';

    final parts = localeString.split('_');

    return Locale(parts[0], parts[1]);
  }
}

enum ThemeOptions{
  dark, light ;
  static ThemeOptions stringToTheme(String themeOption){
    switch(themeOption){
      case "dark":
        return ThemeOptions.dark;
      case "light":
        return ThemeOptions.light;
      default:
        return ThemeOptions.light;
    }
  }
}

