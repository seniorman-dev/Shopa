import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';




class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fallingDot( //threeArchedCircle
        color: AppColor.blackColor,  //orangeColor.withOpacity(0.2),
        size: 35.r,
      ),
    );
  }
}


class Loader2 extends StatelessWidget {
  const Loader2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle( 
        color: AppColor.blackColor,  //orangeColor.withOpacity(0.2),
        size: 35.r,
      ),
    );
  }
}