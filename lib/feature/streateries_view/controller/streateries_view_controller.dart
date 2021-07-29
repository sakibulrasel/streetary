import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/core/model/image_with_caption.dart';
import 'package:streetary/core/model/truck_model.dart';
import 'package:streetary/core/model/truck_model_distance.dart';
import 'package:streetary/feature/add_truck_image/view/add_truck_image_screen.dart';
import 'package:streetary/feature/favourite/controller/favorite_controller.dart';
import 'package:streetary/service/db_service.dart';

/**
 * Created by sakibul.haque on 20,July,2021
 */

class StreateriesViewController extends GetxController
{
  StreateriesViewController(String truckid){
    getImages(truckid);
    getUserId();
    getTruckData(truckid);
  }

  FavouriteController favouriteController = Get.find<FavouriteController>();
  late RxString userid = ''.obs;
  RxBool isLoading = false.obs;
  RxList<ImageWithCaption> imageList= RxList<ImageWithCaption>();
  List<ImageWithCaption> get images => imageList.value;
  RxBool isTruckLoading = false.obs;
  Rx<TruckModel> truckModel = TruckModel("","","","","","","","","","","",new GeoPoint(0, 0),"","",[],[]).obs;
  Rx<TruckModelDistance> truckModelDistance = TruckModelDistance("","","","","","","","","","","",new GeoPoint(0, 0),0,"","",[],false).obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;


  getUserId() async
  {
    User? user =  await FirebaseAuth.instance.currentUser;
    if(user!=null){
      userid.value = user.uid;
    }else{
      userid.value ='';
    }
  }
  getTruckData(String truckid)async{
    isTruckLoading.value = true;
    await DBService.instance.getTruck(truckid).then((value) {
      truckModel.value = value;
      bool isfavorite = false;
      value.userList.forEach((element) {
        if(element==userid.value){
          isfavorite = true;
        }
      });
      truckModelDistance.value = new TruckModelDistance(
          value.uid, value.id, value.name, value.phone, value.email, value.address,
          value.description, value.image, value.starttime, value.endtime,
          value.location, value.geoPosition, 0, value.fblink,
          value.instalink, value.imagelist, isfavorite);
      isTruckLoading.value = false;
    });
  }

  openDialog(String truckId)
  {
    Get.defaultDialog(
        title: 'Select Image',
        middleText: 'Please select your image',
        confirm: ElevatedButton(
            onPressed: (){
              getImage(ImageSource.gallery,truckId);
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.red
            ),
            child: Text('Gallery')
        ),
        cancel: ElevatedButton(
            onPressed: (){
              getImage(ImageSource.camera,truckId);

            },
            style: ElevatedButton.styleFrom(
                primary: Colors.amberAccent
            ),
            child: Text('Camera')
        )
    );
  }

 getImages(String truckid)async
 {
   imageList.bindStream(DBService.instance.truckImage(truckid));
 }

 markAsFavorite(String truckid, String uid) async
 {
    DBService.instance.markAsFavorite(truckid, userid.value).then((value) {
      print('mark as favorite');
      getTruckData(truckid);
      favouriteController.truckList.value.clear();
      favouriteController.getData();
    });
 }

  removeFavorite(String truckid, String uid) async
  {
    DBService.instance.removeFavorite(truckid, userid.value).then((value) {
      print('remove from favorite');
      getTruckData(truckid);
      favouriteController.truckList.value.clear();
      favouriteController.getData();
    });
  }



  void getImage(ImageSource imageSource, String truckid) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile!=null){
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value = (File(selectedImagePath.value).lengthSync()/1024/1024).toStringAsFixed(2)+'MB';
      Get.back();
      Get.to(AddTruckImageScreen(File(selectedImagePath.value),truckid));
    }else{
      Get.snackbar(
          'Error',
          'No Image Selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    }

  }
}