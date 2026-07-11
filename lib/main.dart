import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/app_config_provider.dart';
import 'package:exam_mobile_app/core/di/di.dart';
import 'package:exam_mobile_app/presentation/sign_up_view.dart';
import 'package:exam_mobile_app/presentation/forget_password_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await EasyLocalization.ensureInitialized();
  await getIt<AppConfigProvider>().setDefaultTheme();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("en", "US"),
        Locale("ar", "EG"),
      ],
      path: "assets/lang",
      fallbackLocale: const Locale("en", "US"),
      startLocale: getIt<AppConfigProvider>().getCurrentLocale(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<AppConfigProvider>(),
      builder: (context, child) {
        return Consumer<AppConfigProvider>(
          builder: (context, appConfigProvider, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Exam App',
            theme: getIt<AppTheme>().themeData,
            home: const SignUpView(),
          ),
        );
      }
    );
  }
}

