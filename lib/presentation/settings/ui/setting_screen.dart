import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _check = false;

  bool setLight = false;

  String key = 'keyChangeTheme';

  void checkButton() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _check = prefs.getBool(key) ?? false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Change theme'),
            value: _check,
            onChanged: (bool value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                _check = !_check;
                setLight = !setLight;
                _check
                    ? AdaptiveTheme.of(context).setDark()
                    : AdaptiveTheme.of(context).setLight();
                // _check
                //     ? setLight = !setLight
                //     : setLight = setLight;

                prefs.setBool(key, _check);
              });
            },
            secondary: const Icon(
              FontAwesomeIcons.lightbulb,
              color: Colors.blue,
            ),
            activeColor: Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}
