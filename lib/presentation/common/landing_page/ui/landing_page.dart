import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/presentation/country/ui/country_screen.dart';
import 'package:covid_19/presentation/home/ui/home_screen.dart';
import 'package:covid_19/presentation/profile/ui/profile_screen.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  final tabs = [
    const HomeScreen(),
    const CountryScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: tabs[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        elevation: 3,
        curveSize: 100,
        height: 50,
        backgroundColor: AppConfig.kPrimaryColor,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.map, title: 'Countries'),
          TabItem(icon: Icons.person, title: 'Profile')
        ],
        initialActiveIndex: 0, //optional, default as 0
      ),
    );
  }
}
