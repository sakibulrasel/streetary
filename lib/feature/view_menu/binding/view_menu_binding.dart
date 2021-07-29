import 'package:get/get.dart';
import 'package:streetary/feature/view_menu/controller/view_menu_controller.dart';

/**
 * Created by sakibul.haque on 14,July,2021
 */
class ViewMenuBinding extends Bindings
{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ViewMenuController());
  }

}