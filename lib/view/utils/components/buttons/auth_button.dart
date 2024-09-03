import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key, 
    required this.onPressed, 
    required this.backgroundColor, 
    required this.text, 
    required this.textColor,
  });

  final VoidCallback onPressed;
  final Color backgroundColor; // List of colors for the gradient
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        //height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          /*gradient: LinearGradient(
            colors: gradientColors, // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),*/
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: GoogleFonts.hind(
            color: textColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
