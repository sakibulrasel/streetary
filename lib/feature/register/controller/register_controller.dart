import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/routes/app_routes.dart';
import 'package:streetary/service/cloud_storage_service.dart';
import 'package:streetary/service/db_service.dart';
import 'package:streetary/service/location_service.dart';

import '../../profile/controller/profile_controller.dart';

class RegisterController extends GetxController
{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late String _location;
  late GeoPoint _geoPosition;
  late LocationPermission permission;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  UploadTask? task;
  RxBool isLoginComplete = false.obs;
  RegisterController()
  {
    checkUserGps();
  }
  checkUserGps() async
  {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    getLocationString().then((value){
      _location = value;
      _geoPosition = createGeoPoint(value);

    });
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile!=null){
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value = (File(selectedImagePath.value).lengthSync()/1024/1024).toStringAsFixed(2)+'MB';

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

  performRegistration(ProfileController profileController) async
  {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text);
    if(nameController.text.isEmpty){
      Get.snackbar("Name", 'Please Enter Your Name',snackPosition: SnackPosition.BOTTOM);
    }else{
      if(emailController.text.isEmpty || !emailValid){
        Get.snackbar("Email", 'Please Enter Valid Email',snackPosition: SnackPosition.BOTTOM);
      }else{
        if(passwordController.text.isEmpty || passwordController.text.length<8){
          Get.snackbar("Name", 'Please Enter Valid Password',snackPosition: SnackPosition.BOTTOM);
        }else{
          try{
            isLoginComplete.value = true;
            User? user = (await firebaseAuth.createUserWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text)).user;

            if(user!=null){
              String imageurl;
              if(selectedImagePath.value!=''){
                task = CloudStorageService.uploadFile('profile_images',File(selectedImagePath.value));
                if(task == null) return;
                final snapshot = await task!.whenComplete(() {});
                imageurl = await snapshot.ref.getDownloadURL();
              }else{
                imageurl ='';
              }
              await DBService.instance.createUserInDB(
                  user.uid,
                  nameController.text,
                  emailController.text,
                  imageurl,
                  _location,
                  _geoPosition);
              isLoginComplete.value = false;
              profileController.checkLoginStatus();
              Get.offAndToNamed(Routes.DASHBOARD);
            }else{
              isLoginComplete.value = false;
              Get.snackbar("Error", 'Something went wrong please try later',snackPosition: SnackPosition.BOTTOM);
            }
          }catch(error){
            isLoginComplete.value = false;
            Get.snackbar("Error", 'Something went wrong please try later',snackPosition: SnackPosition.BOTTOM);
          }

        }
      }
    }
    isLoginComplete.value = false;
  }


}