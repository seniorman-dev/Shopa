import 'package:get/get.dart';
import 'package:shopa/controller/repository/data_service/base_service/base_service.dart';
import 'package:shopa/controller/repository/db_helper/db_service.dart';
import 'package:shopa/controller/repository/network_service/network_service.dart';




class MyBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => BaseService(),);  //fenix: true
    Get.lazyPut(() => DatabaseService(), fenix: true); 
    Get.lazyPut(() => ConnectivityController());
  }
  
}