import 'package:flutter/material.dart';

final class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFAFAFA);
  static const Color mainBg = Color(0xff202258);

  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xFF171717);
  static const Color parisM = Color(0xFF212359);

  static const Color dogerBlue = Color(0xff007AFF);

  static const Color amaranth = Color(0xFFE72F59);
  static const Color camboge = Color(0xFFEC8C0B);
  static const Color summerSky = Color(0xff1D96DC);
  static const Color blueViolet = Color(0xFF9B32E1);
}

class AppGradient {
  static const Gradient gradient = LinearGradient(
    colors: [
      Color(0xFFBB51FF),
      Color(0xFFFFBA5D),
      Color(0xff48BCFF),
      Color(0xFFFF3E6C),
    ],
  );
}
