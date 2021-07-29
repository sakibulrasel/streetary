import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:streetary/routes/app_routes.dart';

import '../../../core/model/user_model.dart';
import '../../../service/db_service.dart';
import '../../profile/controller/profile_controller.dart';

class DashboardController extends GetxController
{
  DashboardController(){
    getUserData();
  }
  RxBool isLoading = false.obs;
  Rx<UserModel> userModel = UserModel("","","","","","",new GeoPoint(0, 0)).obs;
  getUserData()async{
    isLoading.value = true;
    User? user =  await FirebaseAuth.instance.currentUser;
    if(user!=null){
      DBService.instance.getUser(user.uid).then((value) {
        userModel.value = value;
        isLoading.value = false;
      });

    }else{
      print("No Data Found");
    }
  }
    signOut(ProfileController profileController) async
    {
      await FirebaseAuth.instance.signOut();
      profileController.checkLoginStatus();
      Get.offAndToNamed(Routes.HOME);
    }

    Future<bool> onWillPop() async {
      Get.offAndToNamed(Routes.INITIAL);
      return false;
    }
}