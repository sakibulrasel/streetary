import 'package:get/get.dart';
import 'package:streetary/core/model/menu_model.dart';
import 'package:streetary/core/model/truck_model_distance.dart';
import 'package:streetary/service/db_service.dart';

class MenuController extends GetxController
{

  MenuController(TruckModelDistance truckModelDistance)
  {
      getMenu(truckModelDistance.id);
  }

  RxBool showSheet = false.obs;

  RxList<MenuModel> menuList = RxList<MenuModel>();

  List<MenuModel> get menus => menuList.value;

  gotoRateScreen(){
    Get.snackbar('Login', 'You Have to Login first to rate this menu');

  }

  getMenu(String truckid)
  {
    menuList.bindStream(DBService.instance.getMenu(truckid));
  }
}