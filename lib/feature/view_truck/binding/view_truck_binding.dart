import 'package:get/get.dart';
import 'package:streetary/feature/view_truck/controller/view_truck_controller.dart';

/**
 * Created by sakibul.haque on 13,July,2021
 */

class ViewTruckBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ViewTruckController());
  }

}