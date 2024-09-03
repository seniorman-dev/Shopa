import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopa/controller/repository/db_helper/db_service.dart';
import 'package:shopa/controller/repository/db_helper/singleton_cfs.dart';
import 'package:shopa/controller/repository/db_helper/singleton_fcs.dart';
import 'package:shopa/model/product_model.dart';
import 'package:shopa/view/screens/home/widget/input_fields.dart';
import 'package:shopa/view/screens/home/widget/selector.dart';
import 'package:shopa/view/utils/components/buttons/auth_button.dart';
import 'package:shopa/view/utils/components/buttons/back_button.dart';
import 'package:shopa/view/utils/components/buttons/upload_image_button.dart';
import 'package:shopa/view/utils/components/loader.dart';
import 'package:shopa/view/utils/components/my_snackbar.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';







class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key,});


  @override
  Widget build(BuildContext context) {

    //screen arguments here (Powered by GetX routing)
    final Map<String, dynamic> arguments = Get.arguments;
    final FirebaseService firebaseService = arguments['firebase_service'];
    final DatabaseService service = arguments["database_service"];
    final String id = arguments["id"];
    final String name = arguments["name"];
    final String description = arguments["description"];
    final String category = arguments["category"];
    final String image = arguments["image"];
    final List<dynamic> image_list = arguments["image_list"];
    final double price = arguments["price"];


    final FirebaseStorageService firebaseStorage = FirebaseStorageService.instance;


    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.lightWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: MediaQuery.of(context).size.height * 0.03), 

              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  CupertinoIcons.arrow_left,
                  color: AppColor.blackColor,
                  size: 24.r,
                ),
              ),
              /*CustomBackButton(
                onTap: () {
                  Get.back();
                }
              ),*/
                      
              SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
        
              Text(
                textAlign: TextAlign.start,
                "Edit product",
                style: GoogleFonts.hind(
                  color: AppColor.blackColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
        
              SizedBox(height: MediaQuery.of(context).size.height * 0.03), 

              Text(
                "Name",
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.greyColor, //fieldGreyColor
                )
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
              InputTextFieldEdit(
                onChanged: (val) {
                  service.productNameControllerEdit.text = val;
                }, 
                onFieldSubmitted: (val) {}, 
                hintText: "enter product name", 
                keyboardType: TextInputType.name, 
                textInputAction: TextInputAction.next, 
                initialValue: name,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03), 

              Text(
                "Price",
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.greyColor, //fieldGreyColor
                )
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
              InputTextFieldEdit(
                onChanged: (val) {
                  service.productPriceControllerEdit.text = val;
                }, 
                onFieldSubmitted: (val) {}, 
                hintText: "enter product price", 
                keyboardType: TextInputType.number, 
                textInputAction: TextInputAction.next, 
                initialValue: price.toString(),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              Text(
                "Description",
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.greyColor
                )
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
              InputTextFieldEdit(
                onChanged: (val) {
                  service.productDescriptionControllerEdit.text = val;
                }, 
                onFieldSubmitted: (val) {}, 
                hintText: "enter product description", 
                keyboardType: TextInputType.text, 
                textInputAction: TextInputAction.next, 
                initialValue: description,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03), 

              Text(
                "Category",
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.greyColor, //fieldGreyColor
                )
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
              Obx(
                () {
                  return SelectorButton(
                    buttonColor: Colors.grey.shade200,
                    dropdownOverlay: DropdownButton<String>(
                      style: GoogleFonts.hind(
                        color: AppColor.blackColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      ),
                      elevation: 2,
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      dropdownColor: AppColor.whiteColor,  //lightWhiteColor,
                      underline: const SizedBox(),
                      borderRadius: BorderRadius.circular(20.r),
                      iconEnabledColor: AppColor.greyColor.withOpacity(0.6),
                      icon: Icon(
                        color: AppColor.greyColor.withOpacity(0.6),
                        CupertinoIcons.chevron_down,
                      ),
                      iconSize: 20.r,
                      isExpanded: true,
                      enableFeedback: true,
                      value: service.productCategory.value,
                      onChanged: (newValue) {
                        // When the user selects an option, update the selectedValue
                        service.toggleProductType(newValue);
                      },
                      items: service.items.map((item) {
                        return DropdownMenuItem(
                          onTap: () {
                            debugPrint("drop down menu tapped!!");
                          },
                          value: item,
                          child: Text(
                            item,
                            style: GoogleFonts.hind(
                              color: AppColor.greyColor.withOpacity(0.6), //AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              ),


              SizedBox(height: MediaQuery.of(context).size.height * 0.05),

              Obx(
                () {
                  return service.isImageSelected.value 
                  ?
                  Container(
                    alignment: Alignment.bottomRight,
                    height: 300.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.grey.shade200,
                      image: DecorationImage(
                        image: FileImage(
                          service.productImage.value!,
                        ),
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            service.pickProductImageGallery(
                              onSuccess: () async{
                                await firebaseStorage.uploadFile(file: service.productImage.value!, path: "products/images");
                              }
                            );
                          },
                          child: Icon(
                            color: AppColor.blackColor,
                            size: 24.r,
                            Icons.edit
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        InkWell(
                          onTap: () {
                            firebaseStorage.responseUrl.value = "";
                            service.isImageSelected.value = false;
                            service.productImage.value = null;
                          },
                          child: Icon(
                            color: AppColor.blackColor,
                            size: 24.r,
                            CupertinoIcons.xmark
                          ),
                        )
                      ],
                    )
                  )
              
                  :Container(
                    alignment: Alignment.bottomRight,
                    height: 300.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.grey.shade200,
                      image: DecorationImage(
                        image: NetworkImage(
                          image
                        ),
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        service.pickProductImageGallery(
                          onSuccess: () async{
                            await firebaseStorage.uploadFile(file: service.productImage.value!, path: "products/${Random().nextInt(2500)}");
                          }
                        );
                      },
                      child: Icon(
                        color: AppColor.blackColor,
                        size: 24.r,
                        Icons.edit
                      ),
                    )
                  );
                }
              ),

              //PRODUCT IMAGE//

              SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              
              Obx(
                () {
                  return firebaseService.isLoading.value || firebaseStorage.isLoading.value ? const Loader2() : AuthButton(
                    onPressed: () async{
                      await firebaseService.updateDocument(
                        "products",
                        id,
                        {
                          "name": service.productNameControllerEdit.text.isNotEmpty ? service.productNameControllerEdit.text : name,
                          "description": service.productDescriptionControllerEdit.text.isNotEmpty ? service.productDescriptionControllerEdit.text : description,
                          "category": service.productCategory.value,
                          "image": firebaseStorage.responseUrl.value.isNotEmpty ? firebaseStorage.responseUrl.value : image,
                          "image_list": [
                            firebaseStorage.responseUrl.value.isNotEmpty ? firebaseStorage.responseUrl.value : image, 
                            firebaseStorage.responseUrl.value.isNotEmpty ? firebaseStorage.responseUrl.value : image, 
                            firebaseStorage.responseUrl.value.isNotEmpty ? firebaseStorage.responseUrl.value : image,
                            firebaseStorage.responseUrl.value.isNotEmpty ? firebaseStorage.responseUrl.value : image,
                            firebaseStorage.responseUrl.value.isNotEmpty ? firebaseStorage.responseUrl.value : image
                          ],
                          "price": service.productPriceControllerEdit.text.isNotEmpty ? double.parse(service.productPriceControllerEdit.text) : price
                        },
                        () {
                          service.isImageSelected.value  = false;
                          service.productImage.value = null;
                          firebaseStorage.responseUrl.value = "";
                          service.productNameControllerEdit.clear();
                          service.productDescriptionControllerEdit.clear();
                          service.productPriceControllerEdit.clear();
                          Get.back();
                          showMySnackBar(backgroundColor: AppColor.greenColor, message: "product updated successfully");
                        }
                      );
                    
                    }, 
                    backgroundColor: AppColor.blackColor,
                    text: "Update product", 
                    textColor: AppColor.whiteColor
                  );
                }
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            ]
          )
        )
      )
    );

  }
}