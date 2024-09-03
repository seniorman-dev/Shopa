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
import 'package:shopa/controller/repository/network_service/network_service.dart';
import 'package:shopa/main.dart';
import 'package:shopa/model/product_model.dart';
import 'package:shopa/view/routes/web_routes.dart';
import 'package:shopa/view/screens/home/widget/search_field.dart';
import 'package:shopa/view/utils/components/loader.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';








class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final FirebaseService firebaseService = FirebaseService.instance;
  final DatabaseService service = Get.find<DatabaseService>();
  //just call the network controller here that's all.
  final ConnectivityController networkController = Get.find<ConnectivityController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.lightWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [AppColor.blackColor, AppColor.orangeColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        textAlign: TextAlign.start,
                        'Shopa',
                        style: GoogleFonts.hind(
                          color: AppColor.lightCreamColor, //blackColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              AddProductPageRoute,
                              arguments: {
                                "firebase_service": firebaseService,
                                "database_service": service
                              }
                            );
                          },
                          child: Icon(
                            size: 24.r,
                            color: AppColor.blackColor,
                            CupertinoIcons.add_circled
                          ),
                        ),
                      ],
                    )
                  ]
                )
              ),
          
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w,),
                child: SearchTextField(
                  onChanged: (val) {
                    setState(() {
                      service.searchController.text = val.toLowerCase();
                      log("val: ${service.searchController.text}");
                    });
                  },
                  onFieldSubmitted: (val) {},
                  hintText: 'search by category',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  textController: service.searchController,
                ),
              ),
          
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: firebaseService.readCollection('products', "name"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader2();
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
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

                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    final List<Product> product = documents.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>)).toList();

                    // Perform client-side filtering based on searchQuery
                    final List<Product> filteredProducts = product.where((p) {
                      return p.category.toLowerCase().contains(service.searchController.text);
                    }).toList();

                    
                    if (filteredProducts.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w,),
                          child: SvgPicture.asset("assets/svg/no_view.svg"),
                        )
                      );
                    }
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w,),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredProducts.length,
                      separatorBuilder: (context, index) => SizedBox(width: 15.w,),
                      itemBuilder: (context, index) {
                            
                        final data = filteredProducts[index];
                                  
                        return InkWell(
                          onTap: () {             
                            Get.toNamed(
                              ViewProductPageRoute,
                              arguments: {
                                'firebase_service': firebaseService,
                                "database_service": service,
                                "id": data.id,
                                /*"name": data.name,
                                "description": data.description,
                                "category": data.category,
                                "image": data.image,
                                "image_list": data.imageList,
                                "price": data.price,*/
                              }
                            );
                          },
                          child: Container(
                            //height: 300.h,
                            width: 320.w,  //200.w, // Adjust the width based on your design
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.greyColor.withOpacity(0.2), //Colors.black12,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Product Image
                                AspectRatio(
                                  aspectRatio: 0.75,  // Adjust the aspect ratio to fit the design
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                                    //height: 450.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.r),
                                        topRight: Radius.circular(16.r),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(data.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        color: AppColor.orangeColor.withOpacity(0.7),
                                        size: 24.r,
                                        CupertinoIcons.heart
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Product Title
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w,),
                                  child: Text(
                                    data.name,
                                    style: GoogleFonts.hind(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: AppColor.greyColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Product Price
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w,),
                                  child: Text(
                                    "${currency(context).currencySymbol}${data.price}",
                                    style: GoogleFonts.hind(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      color: AppColor.orangeColor.withOpacity(0.7),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // Add to Cart Button (Optional)
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                ),
              ),
          
              //SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          
            ]
          ),
        )
      )
    );
  }
}