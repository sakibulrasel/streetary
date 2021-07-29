import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:streetary/feature/favourite/controller/favorite_controller.dart';
import 'package:streetary/routes/app_routes.dart';

class ProfileController extends GetxController
{
  ProfileController(){
    checkLoginStatus();
    refreshFavourite();
  }

  RxBool isLoggedin = false.obs;


  refreshFavourite()
  {
    try{
      FavouriteController favouriteController = Get.find<FavouriteController>();
      favouriteController.truckList.value.clear();
      favouriteController.truckmodelDistanceList.value.clear();
      favouriteController.getData();
    }catch(error){
      print(error.toString());
      Get.put(FavouriteController());
      FavouriteController favouriteController = Get.find<FavouriteController>();
      favouriteController.truckList.value.clear();
      favouriteController.truckmodelDistanceList.value.clear();
      favouriteController.getData();
    }
    if(Get.find<FavouriteController>()== null){

    }else{

    }
  }

  checkLoginStatus() async
  {
    User? user =  await FirebaseAuth.instance.currentUser;
    if(user!=null)
    {
      isLoggedin.value = true;
      update();
    }else{
      isLoggedin.value = false;
      update();
    }
  }

  signOut() async
  {
    await FirebaseAuth.instance.signOut();
    checkLoginStatus();
    refreshFavourite();
    Get.offAndToNamed(Routes.HOME);
  }

}