import 'package:get/get.dart';
import 'package:streetary/feature/new_menu/controller/new_menu_controller.dart';

/**
 * Created by sakibul.haque on 14,July,2021
 */
class NewMenuBindings extends Bindings
{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NewMenuController());
  }

}