import 'package:api/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class MyAppTextStyles {
  static final montserrat700size24 = GoogleFonts.quicksand(
    fontSize: 24.sp,
    fontWeight: FontWeight.w900,
    color: MyAppColors.secondaryColor,
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
