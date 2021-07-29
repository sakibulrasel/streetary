import 'package:get/get.dart';
import 'package:streetary/feature/dashboard/controller/dashboard_controller.dart';
import 'package:streetary/feature/edit_menu/controller/edit_menu_controller.dart';
import 'package:streetary/feature/edit_truck/controller/edit_truck_controller.dart';

class DashboardBinding extends Bindings
{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(DashboardController());
    Get.put(EditTruckController());
    Get.put(EditMenuController());
  }

}