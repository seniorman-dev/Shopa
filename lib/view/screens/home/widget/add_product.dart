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







class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key,});


  @override
  Widget build(BuildContext context) {


    //screen arguments here (Powered by GetX routing)
    final Map<String, dynamic> arguments = Get.arguments;
    final FirebaseService firebaseService = arguments['firebase_service'];
    final DatabaseService service = arguments['database_service'];

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
                "Add product",
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
              InputTextField(
                onChanged: (val) {
                  service.productNameController.text = val;
                }, 
                onFieldSubmitted: (val) {}, 
                hintText: "enter product name", 
                keyboardType: TextInputType.name, 
                textInputAction: TextInputAction.next, 
                textController: service.productNameController,
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
              InputTextField(
                onChanged: (val) {
                  service.productPriceController.text = val;
                }, 
                onFieldSubmitted: (val) {}, 
                hintText: "enter product price", 
                keyboardType: TextInputType.number, 
                textInputAction: TextInputAction.next, 
                textController: service.productPriceController,
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
              InputTextField(
                onChanged: (val) {
                  service.productDescriptionController.text = val;
                }, 
                onFieldSubmitted: (val) {}, 
                hintText: "enter product description", 
                keyboardType: TextInputType.text, 
                textInputAction: TextInputAction.next, 
                textController: service.productDescriptionController,
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
                              fontWeight: FontWeight.w400),
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
                  ?/*Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20.r),
                      image: DecorationImage(
                        image: FileImage(service.productImage.value!),
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high
                      )
                    ),
                  )*/
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.file(
                          service.productImage.value!,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high
                        ),
                        SizedBox(width: 30.w,),
                        CloseButton(
                          color: AppColor.blackColor,
                          onPressed: () {
                            service.isImageSelected.value = false;
                            service.productImage.value = null;
                          },
                        )
                      ],
                    ),
                  )
              
                  :ImageButton(
                    onPressed: () {
                      service.pickProductImageGallery(
                        onSuccess: () async{
                          await firebaseStorage.uploadFile(file: service.productImage.value!, path: "products/${Random().nextInt(2500)}");
                        }
                      );
                    }, 
                    text: "Upload image"
                  );
                }
              ),

              //PRODUCT IMAGE//

              SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              
              Obx(
                () {
                  return firebaseService.isLoading.value || firebaseStorage.isLoading.value ? const Loader2() : AuthButton(
                    onPressed: () async{
                      if(service.productNameController.text.isNotEmpty 
                      && service.productDescriptionController.text.isNotEmpty 
                      && service.productPriceController.text.isNotEmpty 
                      && firebaseStorage.responseUrl.value.isNotEmpty) {
                        await firebaseService.createDocument(
                          "products",
                          {
                            "name": service.productNameController.text,
                            "description": service.productDescriptionController.text,
                            "category": service.productCategory.value,
                            "image": firebaseStorage.responseUrl.value,
                            "image_list": [
                              firebaseStorage.responseUrl.value, 
                              firebaseStorage.responseUrl.value, 
                              firebaseStorage.responseUrl.value,
                              firebaseStorage.responseUrl.value,
                              firebaseStorage.responseUrl.value,
                            ],
                            "price": double.parse(service.productPriceController.text)
                          },
                          () {
                            service.isImageSelected.value  = false;
                            service.productImage.value = null;
                            firebaseStorage.responseUrl.value = "";
                            service.productNameController.clear();
                            service.productDescriptionController.clear();
                            service.productPriceController.clear();
                            Get.back();
                            showMySnackBar(backgroundColor: AppColor.greenColor, message: "product added to catalog");
                          }
                        );
                      }
                      else if(firebaseStorage.responseUrl.value.isEmpty) {
                        showMySnackBar(message: "couldn't process image url", backgroundColor: AppColor.blackColor);
                      }
                      else{
                        showMySnackBar(message: "fields must not be empty", backgroundColor: AppColor.blackColor);
                      }
                    }, 
                    backgroundColor: AppColor.blackColor,
                    text: "Add product", 
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