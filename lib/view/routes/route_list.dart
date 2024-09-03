import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopa/view/routes/web_routes.dart';
import 'package:shopa/view/screens/home/screen/home_screen.dart';
import 'package:shopa/view/screens/home/widget/add_product.dart';
import 'package:shopa/view/screens/home/widget/edit_product.dart';
import 'package:shopa/view/screens/home/widget/view_product.dart';
import 'package:shopa/view/screens/splash/layout_builder.dart';
import 'package:shopa/view/screens/splash/splash_screen.dart';





List<GetPage<dynamic>>? getPages = [
  
  //SplashScreen
  GetPage(
    name: SplashPageRoute,
    page: () => const SplashScreen(
      route: LayoutPageRoute,
    ), //MainScreenPageRoute
    curve: Curves.bounceInOut,
    transition: Transition.rightToLeft,
  ),

  //Layout
  GetPage(
    name: LayoutPageRoute,
    page: () => const LayoutWidget(),
    curve: Curves.bounceInOut,
    transition: Transition.rightToLeft,
  ),

  //Home/Main Page
  GetPage(
    name: MainScreenPageRoute,
    page: () => const HomeScreen(),
    curve: Curves.bounceInOut,
    transition: Transition.rightToLeft,
  ),


  //ADD PRODUCT
  GetPage(
    name: AddProductPageRoute,
    page: () => const AddProductScreen(),
    curve: Curves.bounceInOut,
    transition: Transition.rightToLeft,
  ),
  //EDIT PRODUCT
  GetPage(
    name: EditProductPageRoute,
    page: () => const EditProductScreen(),
    curve: Curves.bounceInOut,
    transition: Transition.rightToLeft,
  ),
  //View PRODUCT
  GetPage(
    name: ViewProductPageRoute,
    page: () => const ViewProductScreen(),
    curve: Curves.bounceInOut,
    transition: Transition.rightToLeft,
  ),

];
