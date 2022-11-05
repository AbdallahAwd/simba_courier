import 'package:flutter/material.dart';

class FontFamily {
  static const String monst = "Montserrat";
  static const String monstAlt = "MontserratAlternates";
}

class AppStyle {
  //small
  static const TextStyle small = TextStyle(
    fontSize: 9,
    fontFamily: FontFamily.monst,
  );
  //small-normal
  static const TextStyle smallMid = TextStyle(
    fontSize: 12,
    fontFamily: FontFamily.monst,
  );
  static const TextStyle smallMidAlt = TextStyle(
    fontSize: 12,
    fontFamily: FontFamily.monstAlt,
  );

  //caption
  static const TextStyle caption = TextStyle(
      fontSize: 16,
      color: Colors.grey,
      fontFamily: FontFamily.monst,
      fontWeight: FontWeight.w400);

  static const TextStyle captionAlt = TextStyle(
      fontSize: 16,
      color: Colors.grey,
      fontFamily: FontFamily.monstAlt,
      fontWeight: FontWeight.w400);

  //Normal
  static const TextStyle normal = TextStyle(
      fontSize: 16, fontFamily: FontFamily.monst, fontWeight: FontWeight.bold);

  static const TextStyle normalAlt = TextStyle(
      fontSize: 14,
      fontFamily: FontFamily.monstAlt,
      fontWeight: FontWeight.bold);
  //meduim
  static const TextStyle medium = TextStyle(
      fontSize: 24, fontFamily: FontFamily.monst, fontWeight: FontWeight.bold);
  static const TextStyle mediumAlt = TextStyle(
      fontSize: 24,
      fontFamily: FontFamily.monstAlt,
      fontWeight: FontWeight.bold);
  //big
  static const TextStyle big = TextStyle(
    fontSize: 40,
    fontFamily: FontFamily.monstAlt,
  );

  static TextStyle customStyle({
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
        fontSize: fontSize ?? 16,
        fontFamily: fontFamily ?? FontFamily.monst,
        color: color,
        fontWeight: fontWeight ?? FontWeight.bold);
  }
}
