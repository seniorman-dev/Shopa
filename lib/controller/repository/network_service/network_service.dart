import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;
import 'package:shopa/view/utils/components/my_snackbar.dart';
import 'package:shopa/view/utils/theme/app_theme.dart';







class ConnectivityController extends GetxController {


  // Observable list for connection status
  var connectionStatus = <ConnectivityResult>[ConnectivityResult.none].obs;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  // Initialize the connectivity check
  Future<void> initConnectivity() async {
    
    try {
      /*List<ConnectivityResult> result = <ConnectivityResult>[ConnectivityResult.none];
      List<ConnectivityResult> result = await _connectivity.checkConnectivity();*/
      await _connectivity.checkConnectivity();
    } on PlatformException catch (e, stackTrace) {
      developer.log('Couldn\'t check connectivity status', error: e, stackTrace: stackTrace);
      return;
    }

    /*if (Get.isRegistered<ConnectivityController>()) {
      _updateConnectionStatus(result);
    }*/
  }

  // Update connection status
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    connectionStatus.value = result;
    developer.log('Connectivity changed: $result');
    // Check the connectivity status and display the corresponding message
    if (connectionStatus.contains(ConnectivityResult.none)) {
      showMySnackBar(message: "No Internet Connection", backgroundColor: AppColor.blackColor);
    } 
    else if (connectionStatus.contains(ConnectivityResult.wifi)) {         
      showMySnackBar(message: "Connected to WiFi", backgroundColor: AppColor.greenColor);
    } 
    else if (connectionStatus.contains(ConnectivityResult.mobile)) {
      showMySnackBar(message: "Connected to Mobile Data", backgroundColor: AppColor.greenColor);
    } 
    else {
      showMySnackBar(message: "Unknown Connectivity Status", backgroundColor: AppColor.blackColor);
    }
  }



  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    // Subscribe to connectivity changes and update the connection status
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
