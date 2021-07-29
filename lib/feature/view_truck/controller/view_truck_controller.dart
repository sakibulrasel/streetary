import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:streetary/core/model/truck_model.dart';

import '../../../service/db_service.dart';
import '../../../service/db_service.dart';

/**
 * Created by sakibul.haque on 13,July,2021
 */
class ViewTruckController extends GetxController{
  RxBool isLoading = false.obs;

  RxList<TruckModel> truckList = RxList<TruckModel>();

  List<TruckModel> get trucks => truckList.value;

  deleteTruck(String truckId, String imageUrl)
  {
    DBService.instance.deleteTruckInDB(truckId, imageUrl);
    Get.back();
  }

  @override
  void onInit() async{
    // TODO: implement onInit

    User? user = await FirebaseAuth.instance.currentUser;
    if(user!=null){
      truckList.bindStream(DBService.instance.truckStream(user.uid));
      //Stream coming from firestore
    }
    super.onInit();
  }
}