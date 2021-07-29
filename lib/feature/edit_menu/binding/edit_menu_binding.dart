import 'package:get/get.dart';
import 'package:streetary/feature/edit_menu/controller/edit_menu_controller.dart';

/**
 * Created by sakibul.haque on 14,July,2021
 */
class EditMenuBinding extends Bindings
{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(EditMenuController());
  }

}