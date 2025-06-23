import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialSignInButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const SocialSignInButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      label: Text(
        text,
        style: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
          side:
              borderColor != null
                  ? BorderSide(color: borderColor!, width: 2.5)
                  : BorderSide.none,
        ),
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      ),
    );
  }
}
