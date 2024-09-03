import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';




class CustomTPAuthButton extends StatelessWidget {
  const CustomTPAuthButton({super.key, required this.onTap, required this.asset});
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70.h, //60.h,
        //width: 40.w,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.lightCreamColor,
          borderRadius: BorderRadius.circular(20.r),
          //border: Border.all(width: 0.8, style: BorderStyle.solid, color: AppColor.greyColor)
        ),
        child: Image.asset(asset),
      ),
    );
  }
}