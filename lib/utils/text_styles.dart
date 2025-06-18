import 'package:api/utils/colors.dart';
import 'package:flutter/material.dart';

abstract class MyAppTextStyles {
  static final pacifico400size64 = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 64,
    fontWeight: FontWeight.w400,
    color: MyAppColors.deepBrown,
  );
  static final pacifico400size28 = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: MyAppColors.deepBrown,
  );
  static const pacifico700size32 = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const poppins300size16 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
  static final poppins400size16 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyAppColors.deepBrown,
  );
  static const poppins500size16 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );
  static const poppins500size24 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static const poppins600size28 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}
