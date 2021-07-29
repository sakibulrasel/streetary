import 'package:get/get.dart';
import 'package:streetary/feature/favourite/controller/favorite_controller.dart';
import 'package:streetary/feature/profile/controller/profile_controller.dart';
import 'package:streetary/feature/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings
{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SplashController());
  }

}