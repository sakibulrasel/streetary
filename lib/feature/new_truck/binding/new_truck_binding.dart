import 'package:get/get.dart';
import 'package:streetary/feature/new_truck/controller/new_truck_controller.dart';

/**
 * Created by sakibul.haque on 12,July,2021
 */

class NewTruckBinding extends Bindings
{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NewTruckController());
  }

}