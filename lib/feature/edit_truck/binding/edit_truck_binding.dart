import 'package:get/get.dart';
import 'package:streetary/feature/edit_truck/controller/edit_truck_controller.dart';

/**
 * Created by sakibul.haque on 13,July,2021
 */
class EditTruckBinding extends Bindings
{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(EditTruckController());
  }

}