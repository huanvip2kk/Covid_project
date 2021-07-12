import 'package:covid_19/config/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({Key? key, required this.onPress}) : super(key: key);

  final Function onPress;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Failure connect',
            style: AppConfig.kSize24WeightBold,
          ),
          ElevatedButton(
            onPressed: () {
              onPress();
            },
            child: Text(
              'Reload',
              style: AppConfig.kSize24WeightBoldColorWhite,
            ),
          ),
        ],
      ),
    );
  }
}

Widget loading() {
  return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitChasingDots(
          color: AppConfig.kPrimaryColor,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Loading...',
          style: AppConfig.kSize14WeightBold,
        ),
      ],
    ),
  );
}
