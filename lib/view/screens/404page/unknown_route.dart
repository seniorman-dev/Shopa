import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';








class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key, required this.onPressed,});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: AppColor.greyColor.withOpacity(0.2),
              width: double.infinity,
              height: 7.h,
            ),
            SizedBox(height: 160.h,),
            SvgPicture.asset('assets/svg/no_view.svg'),
            SizedBox(height: 30.h,),
            Text(
              'Page not found',
              style: GoogleFonts.hind(
                textStyle: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600
                )
              )
            ),
            SizedBox(height: 30.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:"this is an unknown route",
                      style: GoogleFonts.hind(
                        textStyle: TextStyle(
                          color:  Colors.grey.shade600, //AppColor.darkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      )
                    ),
                  ]
                )
              ),
            ),
            SizedBox(height: 70.h,),
          ],
        ),
      ),
    );
  }
}





class NoLaptopView extends StatelessWidget {
  const NoLaptopView({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: AppColor.greyColor.withOpacity(0.2),
              width: double.infinity,
              height: 7.h,
            ),
            SizedBox(height: 160.h,),
            SvgPicture.asset('assets/svg/no_view.svg'),
            SizedBox(height: 30.h,),
            Text(
              'Desktop/Tablet view not available',
              style: GoogleFonts.hind(
                textStyle: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600
                )
              )
            ),
            SizedBox(height: 30.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:"  please endeavour to view with mobile",
                      style: GoogleFonts.hind(
                        textStyle: TextStyle(
                          color: Colors.grey.shade600, //AppColor.darkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      )
                    ),
                  ]
                )
              ),
            ),
            SizedBox(height: 70.h,),
          ],
        ),
      ),
    );
  }
}