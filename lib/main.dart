import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/app_config_provider.dart';
import 'package:exam_mobile_app/core/constants/storage_keys.dart';
import 'package:exam_mobile_app/core/di/di.dart';
import 'package:exam_mobile_app/presentation/forget_password_view.dart';
import 'package:exam_mobile_app/presentation/login/cubit/login_cubit.dart';
import 'package:exam_mobile_app/presentation/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';

Future<Widget> getStartScreen() async {
  final prefs = getIt<SharedPreferences>();
  final rememberMe = prefs.getBool(rememberMeKey) ?? false;

  if (rememberMe) {
    return const ForgetPasswordView(); // Replace with home screen
  } else {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const LoginView(),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await EasyLocalization.ensureInitialized();
  await getIt<AppConfigProvider>().setDefaultTheme();
  final startScreen = await getStartScreen();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("en", "US"), Locale("ar", "EG")],
      path: "assets/lang",
      fallbackLocale: const Locale("en", "US"),
      startLocale: getIt<AppConfigProvider>().getCurrentLocale(),
      child: MyApp(startScreen: startScreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startScreen;

  const MyApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<AppConfigProvider>(),
      builder: (context, child) {
        return Consumer<AppConfigProvider>(
          builder: (context, appConfigProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'Exam App',
              theme: getIt<AppTheme>().themeData,
              home: startScreen,
            );
          },
        );
      },
    );
  }
}
