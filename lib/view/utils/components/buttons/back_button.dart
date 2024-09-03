import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';




class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.h, //56.h,
        width: 40.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(width: 0.8, style: BorderStyle.solid, color: Colors.grey.shade200)
        ),
        child: Icon(
          color: AppColor.blackColor,
          size: 20.r,
          CupertinoIcons.chevron_left
        )
      ),
    );
  }
}