import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopa/controller/repository/db_helper/db_service.dart';
import 'package:shopa/controller/repository/db_helper/singleton_cfs.dart';
import 'package:shopa/main.dart';
import 'package:shopa/model/product_model.dart';
import 'package:shopa/view/routes/web_routes.dart';
import 'package:shopa/view/utils/components/buttons/auth_button.dart';
import 'package:shopa/view/utils/components/loader.dart';
import 'package:shopa/view/utils/components/my_snackbar.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';






class ViewProductScreen extends StatelessWidget {
  const ViewProductScreen({super.key});
  


  @override
  Widget build(BuildContext context) {


    //screen arguments here (Powered by GetX routing)
    final Map<String, dynamic> arguments = Get.arguments;
    final FirebaseService firebaseService = arguments["firebase_service"];
    final DatabaseService databaseService = arguments["database_service"];
    final String id = arguments['id'];
    /*final String name = arguments["name"];
    final String description = arguments["description"];
    final String category = arguments["category"];
    final String image = arguments["image"];
    final List<dynamic> image_list = arguments["image_list"];
    final double price = arguments["price"];*/


    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.lightWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: firebaseService.readDocument("products", id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const Loader2());
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                log("snapshot has data?: ${snapshot.hasData}");
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w,),
                    child: SvgPicture.asset("assets/svg/no_view.svg"),
                  )
                );
              }
              if(snapshot.hasError) {
                log("snapshot err: ${snapshot.error}");
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w,),
                    child: SvgPicture.asset("assets/svg/no_view.svg"),
                  )
                );
              }

              // Safely extract the data and avoid casting errors
              final doc = snapshot.data!.data();
              if (doc == null) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w,),
                    child: SvgPicture.asset("assets/svg/no_view.svg"),
                  )
                );
              }
              
              //call the "fromJson" methode
              final Product data = Product.fromJson(doc);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
              
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Icon(
                        CupertinoIcons.arrow_left,
                        color: AppColor.blackColor,
                        size: 24.r,
                      ),
                    ),
                  ),
                  /*CustomBackButton(
                    onTap: () {
                      Get.back();
                    }
                  ),*/
                          
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
                  // Main Product Image
                  Center(
                    child: Obx(() {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          alignment: Alignment.bottomRight,
                          height: 350.h,
                          width: double.infinity,
                          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.transparent, //Colors.grey.shade200,
                            image: DecorationImage(
                              image: NetworkImage(
                                data.imageList[databaseService.selectedImageIndex.value],
                              ),
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.high
                            ),
                          ),
                        ),
                      );
                      /*Image.asset(
                        controller.productImages[controller.selectedImageIndex.value],
                        height: 200,
                        fit: BoxFit.cover,
                      );*/
                    }),
                  ),
              
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02), 
              
                  // Horizontal List of Product Images
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(data.imageList.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            databaseService.selectImage(index);
                          },
                          child: Obx(() {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: databaseService.selectedImageIndex.value == index
                                  ? AppColor.orangeColor.withOpacity(0.2)
                                  : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Image.network(
                                data.imageList[index],
                                height: 80.h,
                                width: 80.w,
                                fit: BoxFit.cover,
                                //fit: BoxFit.contain,
                                filterQuality: FilterQuality.high
                              ),
                            );
                          }),
                        );
                      }),
                    ),
                  ),
              
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
              
                  // Product Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            data.name,
                            style: GoogleFonts.hind(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        Text(
                          "${currency(context).currencySymbol}${data.price}",
                          style: GoogleFonts.hind(
                            color: AppColor.orangeColor.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,   
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02), 
                  
                  //Product Description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      data.description,
                      style: GoogleFonts.hind(
                        color: AppColor.greyColor.withOpacity(0.6),
                        //color: Colors.grey.shade200,  //AppColor.greyColor.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,   
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
              
                  SizedBox(height: MediaQuery.of(context).size.height * 0.075), 
              
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AuthButton(
                            onPressed: () {
                              Get.toNamed(
                                EditProductPageRoute,
                                arguments: {
                                  'firebase_service': firebaseService,
                                  "database_service": databaseService,
                                  "id": data.id,
                                  "name": data.name,
                                  "description": data.description,
                                  "category": data.category,
                                  "image": data.image,
                                  "image_list": data.imageList,
                                  "price": data.price,
                                }
                              );
                            }, 
                            backgroundColor: AppColor.blackColor, 
                            text: "Edit", 
                            textColor: AppColor.whiteColor
                          )
                        ),
                        SizedBox(width: 20.w,),
                        InkWell(
                          onTap: () async{
                            //call a confirmation dialog first
                            showMyDeleteDialog(
                              name: data.name, 
                              firebaseService: firebaseService,
                              onTap: () async{
                                //call the delete API 
                                await firebaseService.deleteDocument(
                                  "products", 
                                  data.id, 
                                  () {
                                    //showMySnackBar(message: "product deleted successfully", backgroundColor: AppColor.blackColor);
                                    Get.back();
                                    Get.back();
                                    showMySnackBar(message: "product deleted successfully", backgroundColor: AppColor.greenColor);
                                  }
                                );
                              }
                            );
                          },
                          child: Container(
                            //height: 70.h
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Icon(
                              color: AppColor.blackColor,
                              size: 24.r,
                              CupertinoIcons.trash
                            ),
                          ),
                        ),
                          
                        
                      ],
                    ),
                  ),
              
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
              
                
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
