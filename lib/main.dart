import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/utils/route/app_routing.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Bloc.observer = SimpleBlocObserver();
  runApp(const Covid19App());
}

class Covid19App extends StatelessWidget {
  const Covid19App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.lightGreen,
          accentColor: AppConfig.kRecoveredColor,
          backgroundColor: Colors.white),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightGreen,
        accentColor: AppConfig.kRecoveredColor,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        onGenerateRoute: AppRouting.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Covid-19 tracking app',
        theme: theme,
        darkTheme: darkTheme,
        initialRoute: RouteDefine.landingPage.name,
      ),
    );
  }
}
