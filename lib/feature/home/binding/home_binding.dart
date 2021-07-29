import 'package:get/get.dart';
import 'package:streetary/feature/home/controller/home_controller.dart';
import 'package:streetary/feature/hotspot/controller/hotspot_controller.dart';
import 'package:streetary/feature/kuzines/controller/kuzines_controller.dart';
import 'package:streetary/feature/profile/controller/profile_controller.dart';
import 'package:streetary/feature/vendors/controller/vendors_controller.dart';
import 'package:streetary/feature/streateries/controller/streateries_controller.dart';

class HomeBinding extends Bindings
{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HomeController(),);
    // Get.lazyPut(() => HomeController(), fenix: true);
  }

}