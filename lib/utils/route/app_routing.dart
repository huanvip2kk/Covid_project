import 'package:covid_19/data/model/countries_model.dart';
import 'package:covid_19/presentation/common/landing_page/landing_page_route.dart';
import 'package:covid_19/presentation/country/country_screen_route.dart';
import 'package:covid_19/presentation/detail/country_detail/detail_screen_route.dart';
import 'package:covid_19/presentation/detail/favorited_detail/favorited_detail_route.dart';
import 'package:covid_19/data/ultils/favorited_model.dart';
import 'package:covid_19/presentation/favorited/favorited_route.dart';
import 'package:covid_19/presentation/home/home_screen_route.dart';
import 'package:covid_19/presentation/login_and_signup/login/login_route.dart';
import 'package:covid_19/presentation/login_and_signup/signup/signup_route.dart';
import 'package:covid_19/presentation/profile/profile_screen_route.dart';
import 'package:covid_19/presentation/settings/route.dart';
import 'package:covid_19/presentation/welcome_screen/intro/intro_screen_route.dart';
import 'package:covid_19/presentation/welcome_screen/splash_screen/splash_screen_route.dart';
import 'package:flutter/material.dart';

enum RouteDefine {
  homeScreen,
  loginScreen,
  signupScreen,
  splashScreen,
  introScreen,
  countryScreen,
  countryDetailScreen,
  favoritedScreen,
  settingsScreen,
  chartsScreen,
  userProfileScreen,
  landingPage,
  favoritedDetailScreen,
  profileScreenRoute
}

class AppRouting {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.homeScreen.name: (_) => HomeScreenRoute.route,
      RouteDefine.loginScreen.name: (_) => LoginScreenRoute.route,
      RouteDefine.signupScreen.name: (_) => SignupScreenRoute.route,
      RouteDefine.introScreen.name: (_) => IntroScreenRoute.route,
      RouteDefine.countryScreen.name: (_) => CountryScreenRoute.route,
      RouteDefine.countryDetailScreen.name: (_) =>
          CountryDetailScreenRoute.route(settings.arguments as CountriesModel),
      RouteDefine.favoritedScreen.name: (_) => FavoritedScreenRoute.route(),
      RouteDefine.settingsScreen.name: (_) => SettingsScreenRoute.route,
      RouteDefine.splashScreen.name: (_) => SplashScreenRoute.route,
      RouteDefine.landingPage.name: (_) => LandingPageRoute.route,
      RouteDefine.profileScreenRoute.name: (_) => ProfileScreenRoute.route,
      RouteDefine.favoritedDetailScreen.name: (_) => FavoritedDetailScreenRoute.route(settings.arguments as FavoritedModel),
    };

    final routeBuilder = routes[settings.name];

    return MaterialPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}

extension RouteExt on Object {
  String get name => toString().substring(toString().indexOf('.') + 1);
}
