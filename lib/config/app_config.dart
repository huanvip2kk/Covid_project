import 'package:flutter/material.dart';

class AppConfig {
  // Colors

  static Color kBackgroundColor = const Color(0xFFFEFEFE);

  static Color kPrimaryColor = const Color(0xFF59C12C);
  static Color kRecoveredColor = const Color(0xFF054AF8);
  static Color kDangerColor = const Color(0xFFFF0000);




// Text Style common
  static TextStyle kSize24WeightBoldColorWhite = TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: kBackgroundColor);

  static TextStyle kSize24WeightBold =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle kSize14WeightBold =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  static TextStyle kSize14 = const TextStyle(
    fontSize: 14,
  );

  // Text Style detail
  static TextStyle kSize24WeightBoldColorRed = TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: kDangerColor);

  static TextStyle kSize24WeightBoldColorGreen =
   TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: kPrimaryColor);

  static TextStyle kSize24WeightBoldColorBlue =
  TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: kRecoveredColor);


  static TextStyle kSize14WeightBoldColorBlue =
  TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: kRecoveredColor);

  static TextStyle kSize14WeightBoldColorRed =
  TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: kDangerColor);

  static TextStyle kSize14WeightBoldColorGreen =
  TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: kPrimaryColor);
}
