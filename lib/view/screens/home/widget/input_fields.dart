import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';










class InputTextField extends StatefulWidget {
  const InputTextField({super.key,required this.onChanged, required this.onFieldSubmitted, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, this.validator, this.onTap,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onTap: widget.onTap,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 4,
        minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.greyColor,
        style: GoogleFonts.hind(color: AppColor.greyColor.withOpacity(0.6), fontSize: 13.sp, fontWeight: FontWeight.w400),    
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(    
          /*prefixIcon: Icon(
            size: 24.r,
            color: AppColor.greyColor.withOpacity(0.6),
            CupertinoIcons.search
          ),*/
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),   
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Colors.grey.shade200), // Set the color you prefer
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Colors.grey.shade200), // Set the color you prefer
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: AppColor.lightWhiteColor.withOpacity(0.2)), // Set the color you prefer
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: AppColor.redColor), // Set the color you prefer
          ),
          fillColor: Colors.grey.shade200, //AppColor.greyColor.withOpacity(0.2),
          filled: true,    
          hintText: widget.hintText,
          hintStyle: GoogleFonts.hind(color: AppColor.greyColor.withOpacity(0.6), fontSize: 13.sp, fontWeight: FontWeight.w400), 
          errorStyle: GoogleFonts.hind(color: AppColor.redColor, fontSize: 13.sp, fontWeight: FontWeight.w400), 
        ),
      ),
    );
  }
}






class InputTextFieldEdit extends StatefulWidget {
  const InputTextFieldEdit({super.key, this.initialValue, required this.onChanged, required this.onFieldSubmitted, required this.hintText, required this.keyboardType, required this.textInputAction, this.onFocusChanged, this.validator, this.onTap,});
  final TextInputType keyboardType;
  final String hintText;
  final String? initialValue;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;

  @override
  State<InputTextFieldEdit> createState() => _InputTextFieldEditState();
}

class _InputTextFieldEditState extends State<InputTextFieldEdit> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onTap: widget.onTap,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        maxLines: 4,
        minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.greyColor,
        style: GoogleFonts.hind(color: AppColor.greyColor.withOpacity(0.6), fontSize: 13.sp, fontWeight: FontWeight.w400),    
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(    
          /*prefixIcon: Icon(
            size: 24.r,
            color: AppColor.greyColor.withOpacity(0.6),
            CupertinoIcons.search
          ),*/
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),   
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Colors.grey.shade200), // Set the color you prefer
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Colors.grey.shade200), // Set the color you prefer
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: AppColor.lightWhiteColor.withOpacity(0.2)), // Set the color you prefer
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: AppColor.redColor), // Set the color you prefer
          ),
          fillColor: Colors.grey.shade200, //AppColor.greyColor.withOpacity(0.2),
          filled: true,    
          hintText: widget.hintText,
          hintStyle: GoogleFonts.hind(color: AppColor.greyColor.withOpacity(0.6), fontSize: 13.sp, fontWeight: FontWeight.w400), 
          errorStyle: GoogleFonts.hind(color: AppColor.redColor, fontSize: 13.sp, fontWeight: FontWeight.w400), 
        ),
      ),
    );
  }
}


