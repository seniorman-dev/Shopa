import 'dart:convert';
import 'dart:developer';
import "dart:math" as math;
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';
import 'package:shopa/model/product_model.dart';
import 'package:shopa/view/utils/components/my_snackbar.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';







class DatabaseService extends getx.GetxController {
  
  //FOR UNIT TEST PURPOSE
  //TEST PRODUCT LIST
  final List<Product> products = [
    Product(
      id: math.Random().nextInt(2000).toString(), 
      name: "Lazer SQ Tees", 
      description: "This is a super qulity cotton tee shirt with luxury graphics", 
      image: "assets/images/shirt.jpg", 
      imageList: ["assets/images/shirt.jpg", "assets/images/shirt.jpg", "assets/images/shirt.jpg", "assets/images/shirt.jpg"], 
      price: 20.0,
      category: "clothes",
    ),
    Product(
      id: math.Random().nextInt(2000).toString(), 
      name: "Nike SB Low Dunk", 
      description: "This is a super qulity nike sb with steeze", 
      image: "assets/images/shoe.jpg", 
      imageList: ["assets/images/shoe.jpg", "assets/images/shoe.jpg", "assets/images/shoe.jpg", "assets/images/shoe.jpg"], 
      price: 40.0,
      category: "shoes",
    ),
    Product(
      id: math.Random().nextInt(2000).toString(), 
      name: "Nike SB Low Dunk", 
      description: "This is a super qulity nike sb with steeze", 
      image: "assets/images/shoe.jpg", 
      imageList: ["assets/images/shoe.jpg", "assets/images/shoe.jpg", "assets/images/shoe.jpg", "assets/images/shoe.jpg"], 
      price: 40.0,
      category: "shoes",
    ),
    Product(
      id: math.Random().nextInt(2000).toString(), 
      name: "Lazer SQ Tees", 
      description: "This is a super qulity cotton tee shirt with luxury graphics", 
      image: "assets/images/shirt.jpg", 
      imageList: ["assets/images/shirt.jpg", "assets/images/shirt.jpg", "assets/images/shirt.jpg", "assets/images/shirt.jpg"], 
      price: 20.0,
      category: "clothes",
    ),
  ];
  void addProduct(Product data) {
    if(products.contains(data)){
      log("data already exists");
    }
    else{
      products.add(data);
    }
  }


  //PRODUCT DETAILS
  var selectedImageIndex = 0.obs;

  void selectImage(int index) {
    selectedImageIndex.value = index;
  }


  //TEXT CONTROLLERS
  final TextEditingController searchController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productNameControllerEdit = TextEditingController();
  final TextEditingController productDescriptionControllerEdit = TextEditingController();
  final TextEditingController productPriceControllerEdit = TextEditingController();
  
  
  //Product category
  final productCategory = "clothes".obs;
  final List<String> items = [
    'clothes', 
    'shoes',
  ];
  void toggleProductType(String? newValue) {
    productCategory.value = newValue!;
    log("selected category: ${productCategory.value}");
    update();
  }

  
  //Upload product picture
  getx.Rx<File?> productImage = getx.Rx<File?>(null);
  /// checks if any image is selected at all
  var isImageSelected = false.obs;
  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickProductImageGallery({required VoidCallback onSuccess}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        productImage.value = File(pickedImage.path);
        isImageSelected.value = true;
        log("selected image file: ${productImage.value}");
        onSuccess();
      }
    }
    catch (e) {
      debugPrint("Error Picking Image From Gallery: $e");
      isImageSelected.value = false;
      //error snackbar
      showMySnackBar(
        backgroundColor: AppColor.blackColor,
        message: "no photo was selected"
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    productNameController.dispose();
    productDescriptionController.dispose();
    productPriceController.dispose();
    productNameControllerEdit.dispose();
    productDescriptionControllerEdit.dispose();
    productPriceControllerEdit.dispose();
    super.dispose();
  }
}