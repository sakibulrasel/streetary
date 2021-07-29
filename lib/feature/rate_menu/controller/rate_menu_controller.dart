import 'package:get/get.dart';
import 'package:streetary/feature/kuzines/controller/kuzines_controller.dart';
import 'package:streetary/feature/menu/controller/menu_controller.dart';
import 'package:streetary/routes/app_routes.dart';
import 'package:streetary/service/db_service.dart';

class RateMenuController extends GetxController
{
  RxDouble rating = 4.0.obs;

  rateMenu(String menuid, String previousrate, String ratecount,KuzinesController kuzinesController)
  {
    double prevrate = double.parse(previousrate);
    double totalrate = double.parse(ratecount);
    double orgrate = prevrate*totalrate;
    double a = orgrate+rating.value;
    double b = a/(totalrate+1);
    double c = totalrate+1;
    String newrating = b.toString();
    String newratecount = c.toString();
    DBService.instance.updateRatingDB(menuid, newrating,newratecount).then((value) {
      kuzinesController.getKuzines();
      Get.offAndToNamed(Routes.HOME);
    });
  }

  rateMenuTruck(String menuid, String previousrate, String ratecount)
  {
    double prevrate = double.parse(previousrate);
    double totalrate = double.parse(ratecount);
    double orgrate = prevrate*totalrate;
    double a = orgrate+rating.value;
    double b = a/(totalrate+1);
    double c = totalrate+1;
    String newrating = b.toString();
    String newratecount = c.toString();
    DBService.instance.updateRatingDB(menuid, newrating,newratecount).then((value) {
      Get.back();
    });
  }
}