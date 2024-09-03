import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';




class ImageButton extends StatelessWidget {
  const ImageButton({
    super.key, 
    required this.onPressed, 
    required this.text, 
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        //height: 85.h,
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        decoration: BoxDecoration(
          /*gradient: LinearGradient(
            colors: gradientColors, // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),*/
          color:  AppColor.orangeColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(13.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              size: 28.r,
              color: AppColor.orangeColor,
              CupertinoIcons.cloud_upload
            ),
            SizedBox(width: 20.w,),
            Text(
              text,
              style: GoogleFonts.hind(
                color: AppColor.orangeColor,  //.withOpacity(0.1),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
