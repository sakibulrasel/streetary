import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/core/model/user_model.dart';
import 'package:streetary/routes/app_routes.dart';
import 'package:streetary/service/cloud_storage_service.dart';
import 'package:streetary/service/db_service.dart';

class UserProfileController extends GetxController
{
  RxBool isLoading = false.obs;
  Rx<UserModel> userModel = UserModel("","","","","","",new GeoPoint(0, 0)).obs;
  var selectedImagePath = ''.obs;
  UploadTask? task;
  RxBool isUploading = false.obs;
  getUserData()async{
    isLoading.value = true;
    User? user =  await FirebaseAuth.instance.currentUser;
    if(user!=null){
      await DBService.instance.getUser(user.uid).then((value) {
        userModel.value = value;
        isLoading.value = false;
      });

    }else{
      print("No Data Found");
    }
  }



  void updateProfileImage() async
  {
    isUploading.value = true;
    String imageurl;
    if(selectedImagePath.value!=''){
      if(userModel.value.image!=''){
        var photoRef =
        await FirebaseStorage.instance.refFromURL(userModel.value.image);
        photoRef.delete();
      }
      task = CloudStorageService.uploadFile('profile_images',File(selectedImagePath.value));
      if(task == null) return;
      final snapshot = await task!.whenComplete(() {});
      imageurl = await snapshot.ref.getDownloadURL();
    }else{
      imageurl ='';
    }
    await DBService.instance.updateUserInDB(
      userModel.value.uid,imageurl
        ).then((value) {
      selectedImagePath.value = '';
      isUploading.value = false;
      isLoading.value = false;
      userModel.value = UserModel("","","","","","",new GeoPoint(0, 0));
      getUserData();
      Get.toNamed(Routes.USER_PROFILE);
    });

  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile!=null){
      selectedImagePath.value = pickedFile.path;

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

  @override
  void onInit() {
    // TODO: implement onInit
    getUserData();
    super.onInit();
  }
}