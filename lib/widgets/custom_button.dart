import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 10.0,
    this.height = 56.0,
    this.width, 
    this.textStyle,
    this.elevation,
    this.padding,
    this.child,
    this.isLoading = false,
    this.loadingColor,
    this.disabledColor,
    this.enabled = true,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double height;
  final double? width;
  final TextStyle? textStyle;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final bool isLoading;
  final Color? loadingColor;
  final Color? disabledColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: enabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? backgroundColor : disabledColor,
          elevation: elevation,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    loadingColor ?? Colors.white,
                  ),
                ),
              )
            : child ??
                Text(
                  text,
                  style: textStyle?.copyWith(
                        color: textColor,
                      ) ??
                      TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                ),
      ),
    );
  }
}
