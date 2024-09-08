import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopa/controller/bindings/my_bindings.dart';
import 'package:shopa/controller/repository/db_helper/singleton_cfs.dart';
import 'package:shopa/controller/repository/network_service/offline_persistence.dart';
import 'package:shopa/view/routes/route_list.dart';
import 'package:shopa/view/routes/web_routes.dart';
import 'package:shopa/view/screens/404page/unknown_route.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';
import 'firebase_options.dart';
// ignore: depend_on_referenced_packages
import "package:intl/intl.dart";








//to display EURO currency
NumberFormat currency(context) {
  //String os = Platform.operatingSystem;
  //if(Platform.isAndroid)
  Locale locale = Localizations.localeOf(context);
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: "USD");
  //print("CURRENCY SYMBOL: ${format.currencySymbol}");
  //print("CURRENCY NAME: ${format.currencyName}");
  return format;
}

// Define a GlobalKey<NavigatorState> for functional navigation
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  //keep beneath this widgetflutterbinding widget
  //usePathUrlStrategy();
  
  //to customize system overlay
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColor.whiteColor,
      statusBarColor: Colors.transparent, //AppColor.blackColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  //initialize get_storage
  await GetStorage.init();
  
  //initialize firebase 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Enable Firestore offline persistence
  enableFirestoreOfflinePersistence();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    //Access a query parameter from the web url using "Get.parameters['']"
    /*String serviceName = Get.parameters['name'] ?? 'DefaultUserName';*/

    //final String myName = LocalStorage.getUsername() ?? "";


    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) {
        return child!;
      },
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Shopa',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.orangeColor),
          useMaterial3: true,
        ),
        defaultTransition: Transition.rightToLeft,
        
        //incase user gets to an unknown route
        unknownRoute: GetPage(
          name: '/', 
          page: () => UnknownPage(
            onPressed: () {}     
          )
        ),
        
        //traditional way of registering routes without getx
        /*routes: {
          '/': (context) => HomeScreen(),
          '/destination': (context) => DestinationScreen(argument: ''),
        },*/
        initialBinding: MyBindings(),
        
        //mock jwt session check
        initialRoute: SplashPageRoute,
        
        //register all routes for the app here
        getPages: getPages

      
      ),
    );
  }
}
