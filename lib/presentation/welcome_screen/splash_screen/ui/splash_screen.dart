import 'dart:async';

import 'package:covid_19/utils/route/app_routing.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(
            context, RouteDefine.landingPage.name),
      );
    } else {
      await prefs.setBool('seen', true);
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(
            context, RouteDefine.introScreen.name),
      );
    }
  }

  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    afterFirstLayout(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_screen.png',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Covid-19 tracking app',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
