import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';










class SelectorButton extends StatelessWidget {
  const SelectorButton({super.key, required this.buttonColor, required this.dropdownOverlay});
  //final VoidCallback onPressed;
  final Color buttonColor;
  final Widget dropdownOverlay;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: onPressed,
      child: Container(
        //alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: buttonColor,
          //border: 
        ),
        //height: 70.h,
        width: double.infinity,
        child: dropdownOverlay
      ),
    );
  }
}