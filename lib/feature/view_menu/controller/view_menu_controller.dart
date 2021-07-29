import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:streetary/core/model/menu_model.dart';
import 'package:streetary/service/db_service.dart';

/**
 * Created by sakibul.haque on 14,July,2021
 */
class ViewMenuController extends GetxController
{

  RxList<MenuModel> menuList = RxList<MenuModel>();

  List<MenuModel> get menus => menuList.value;

  deleteMenu(MenuModel menuModel)
  {
    DBService.instance.deleteMenuInDB(menuModel).then((value) => Get.back());
  }

  @override
  void onInit() async{
    // TODO: implement onInit
    User? user = await FirebaseAuth.instance.currentUser;
    if(user!=null){
      menuList.bindStream(DBService.instance.menuStream(user.uid));
      //Stream coming from firestore
    }
    super.onInit();
  }
}