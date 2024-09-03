import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopa/view/routes/web_routes.dart';
import 'package:shopa/view/screens/404page/unknown_route.dart';
import 'package:shopa/view/screens/home/screen/home_screen.dart';
import 'package:shopa/view/screens/splash/splash_screen.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';





class LayoutWidget extends StatelessWidget {
  const LayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          //mobile view
          if(constraints.maxWidth < 600) {
            return HomeScreen();
          }
          //web view
          else {
            return const NoLaptopView();
          }
        }
      );
  }
}