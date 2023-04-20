import 'package:flutter/material.dart';

class AppColors {
  static const int primaryColorInt = 0x6eab3f;
  static const int secondaryColorInt = 0xff008f5c;
  static const int accentColorInt = 0x007c3fab;

  static Map<int, Color> get primaryColorSwatch => {
    50: const Color.fromRGBO(109, 171, 63, .1),
    100: const Color.fromRGBO(109, 171, 63, .2),
    200: const Color.fromRGBO(109, 171, 63, .3),
    300: const Color.fromRGBO(109, 171, 63, .4),
    400: const Color.fromRGBO(109, 171, 63, .5),
    500: const Color.fromRGBO(109, 171, 63, .6),
    600: const Color.fromRGBO(109, 171, 63, .7),
    700: const Color.fromRGBO(109, 171, 63, .8),
    800: const Color.fromRGBO(109, 171, 63, .9),
    900: const Color.fromRGBO(109, 171, 63, 1),
  };

  static Map<int, Color> get secondaryColorSwatch => {
    50: const Color.fromRGBO(124, 63, 171, .1),
    100: const Color.fromRGBO(124, 63, 171, .2),
    200: const Color.fromRGBO(124, 63, 171, .3),
    300: const Color.fromRGBO(124, 63, 171, .4),
    400: const Color.fromRGBO(124, 63, 171, .5),
    500: const Color.fromRGBO(124, 63, 171, .6),
    600: const Color.fromRGBO(124, 63, 171, .7),
    700: const Color.fromRGBO(124, 63, 171, .8),
    800: const Color.fromRGBO(124, 63, 171, .9),
    900: const Color.fromRGBO(124, 63, 171, 1),
  };

  static Map<int, Color> get accentColorSwatch => {
    50: const Color.fromRGBO(0, 143, 92, .1),
    100: const Color.fromRGBO(0, 143, 92, .2),
    200: const Color.fromRGBO(0, 143, 92, .3),
    300: const Color.fromRGBO(0, 143, 92, .4),
    400: const Color.fromRGBO(0, 143, 92, .5),
    500: const Color.fromRGBO(0, 143, 92, .6),
    600: const Color.fromRGBO(0, 143, 92, .7),
    700: const Color.fromRGBO(0, 143, 92, .8),
    800: const Color.fromRGBO(0, 143, 92, .9),
    900: const Color.fromRGBO(0, 143, 92, 1),
  };
}
