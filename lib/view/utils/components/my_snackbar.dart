import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopa/controller/repository/db_helper/singleton_cfs.dart';
import 'package:shopa/view/utils/components/loader.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';







Future<void> showMySnackBar({required String message, required Color backgroundColor}) async {
  Get.snackbar(
    "",  // Title (can be empty if not needed)
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    colorText: AppColor.whiteColor,
    borderRadius: 8.0,
    margin: const EdgeInsets.all(16.0),
    duration: const Duration(seconds: 2), // Adjust the duration as needed
    snackStyle: SnackStyle.FLOATING,
    barBlur: 10,
    animationDuration: const Duration(milliseconds: 300),
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: GoogleFonts.hind(
        color: AppColor.whiteColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}




Future<void> showMessagePopup({ 
  required String title,
  required String message,
  required String buttonText, 
  }) async{
  Get.dialog(
    useSafeArea: true,
    barrierDismissible: false,
    transitionCurve: Curves.easeInCubic,
    AlertDialog.adaptive(
      //barrierDismissible: true,
      elevation: 2,
        backgroundColor: AppColor.whiteColor,
        //contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
        content: Wrap(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.hind(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Text(
                    message,
                    style: GoogleFonts.hind(
                      color: AppColor.greyColor.withOpacity(0.6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                    ),
                    overflow: TextOverflow.clip,
                  ),
              
                  //SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                  SizedBox(height: 40.h,),
                    
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        color: AppColor.blackColor,
                        borderRadius: BorderRadius.circular(10.r),  //30.r
                      ),
                      //height: 50.h,
                      //width: 110.w,
                      width: double.infinity,
                      child: Text(
                        buttonText,
                        style: GoogleFonts.hind(
                          color: AppColor.whiteColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600
                        )
                      )
                    ),
                  ),   
              
                ],
              ),
            ),
          ],
        ),
      )
  );
  
}


//Delete Bottom Sheet/ Dialog
Future<void> showMyDeleteDialog({  
  required String name,
  required FirebaseService firebaseService,
  required VoidCallback onTap,
  }) async{
  Get.dialog(
    useSafeArea: true,
    barrierDismissible: false,
    transitionCurve: Curves.easeInCubic,
    AlertDialog.adaptive(
      //barrierDismissible: true,
      elevation: 2,
        backgroundColor: AppColor.whiteColor,
        //contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
        content: Wrap(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 20.h),
              child: Obx(
                () {
                  return firebaseService.isLoading.value ? const Loader2() : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delete "$name"',
                        style: GoogleFonts.hind(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Text(
                        "Are you sure you want to delete this product?",
                        style: GoogleFonts.hind(
                          color: AppColor.greyColor.withOpacity(0.6),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400
                        ),
                        overflow: TextOverflow.clip,
                      ),
                  
                      //SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  
                      SizedBox(height: 40.h,),
                        
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                //height: 70.h
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.hind(
                                    color: AppColor.blackColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w,),
                          Expanded(
                            child: InkWell(
                              onTap: onTap,
                              child: Container(
                                //height: 70.h
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColor.blackColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  "Delete",
                                  style: GoogleFonts.hind(
                                    color: AppColor.whiteColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),   
                  
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      )
  );
  
}
