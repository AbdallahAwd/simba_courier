import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xffcd2936);
  static const Color grey = Color(0xff777777);

  static const MaterialColor pColorSwatch = MaterialColor(
    0xffcd2936, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffcd2936), //10%
      100: Color(0xffcd2936), //20%
      200: Color(0xffcd2936), //30%
      300: Color(0xffcd2936), //40%
      400: Color(0xffcd2936), //50%
      500: Color(0xffcd2936), //60%
      600: Color(0xffcd2936), //70%
      700: Color(0xffcd2936), //80%
      800: Color(0xffcd2936), //90%
      900: Color(0xffcd2936), //100%
    },
  );

  static const List<Color> gradiant = [Color(0xffC22424), Color(0xffFF5B5B)];
  static const List<Color> gradiant2 = [Color(0xffC6C6C6), Color(0xffFFFFFF)];
}
