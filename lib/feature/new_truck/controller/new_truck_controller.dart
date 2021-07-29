import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/core/model/truck_model.dart';

import '../../../routes/app_routes.dart';
import '../../../service/cloud_storage_service.dart';
import '../../../service/db_service.dart';
import '../../../service/location_service.dart';

/**
 * Created by sakibul.haque on 12,July,2021
 */

class NewTruckController extends GetxController
{

  RxString addressLine = ''.obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var companyController = TextEditingController();
  var titleController = TextEditingController();
  var facebookController = TextEditingController();
  var instagramController = TextEditingController();
  UploadTask? task;
  RxBool isLoading = false.obs;
  late GeoPoint _geoPosition;
  late LocationPermission permission;
  late String _location;

  late RxList<TruckModel> truckList;
  RxString selectedStartTime =''.obs;
  RxString selectedEndTime =''.obs;

  List<TruckModel> get trucks => truckList.value;

  // We don't need to pass a context to the _show() function
  // You can safety ubuse context as below
  Future<void> showStartTime(BuildContext context) async {
    final TimeOfDay? result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      selectedStartTime.value = result.format(context);
    }
  }

  Future<void> showEndTime(BuildContext context) async {
    final TimeOfDay? result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      selectedEndTime.value = result.format(context);
    }
  }

  getUserAddress()
  {
    getLocation().then((value) async{
      final coordinates = new Coordinates(value.latitude, value.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      addressLine.value = first.addressLine;
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

  saveTruck() async
  {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text);
    if(nameController.text.isEmpty){
      Get.snackbar("Name", 'Please Enter Your Truck Name',snackPosition: SnackPosition.BOTTOM);
    }else{
      if(phoneController.text.isEmpty ){
        Get.snackbar("Email", 'Please Enter Valid Phone Number',snackPosition: SnackPosition.BOTTOM);
      }else{
        if(emailController.text.isEmpty || !emailValid){
          Get.snackbar("Name", 'Please Enter Valid Email',snackPosition: SnackPosition.BOTTOM);
        }else{
         if(addressController.text.isEmpty){
           Get.snackbar("Address", 'Please Enter Your Address',snackPosition: SnackPosition.BOTTOM);

         }else{
           if(companyController.text.isEmpty){
             Get.snackbar("Company Name", 'Please Enter Company Name',snackPosition: SnackPosition.BOTTOM);
           }else{
             if(selectedImagePath.value==''){
               Get.snackbar("Image", 'Please Select Your Truck Picture',snackPosition: SnackPosition.BOTTOM);
             }else{
               if(selectedStartTime.value==''){
                 Get.snackbar("Opening Time", 'Please Select Your Truck Opening Time',snackPosition: SnackPosition.BOTTOM);
               }else{
                 if(selectedEndTime.value==''){
                   Get.snackbar("Closing Time", 'Please Select Your Truck Closing Time',snackPosition: SnackPosition.BOTTOM);
                 }else{
                   try{
                     String fblink='',instalink='';
                     if(facebookController.text.isEmpty){
                       fblink = '';
                     }else{
                       fblink = facebookController.text;
                     }
                     if(instagramController.text.isEmpty){
                       instalink = '';
                     }else{
                       instalink = instagramController.text;
                     }
                     isLoading.value = true;
                     User? user = await FirebaseAuth.instance.currentUser;
                     if(user!=null){
                       task = CloudStorageService.uploadFile('truck_images',File(selectedImagePath.value));
                       if(task == null) return;
                       final snapshot = await task!.whenComplete(() {});
                       final downloadUrl = await snapshot.ref.getDownloadURL();
                       DBService.instance.saveTruckInDB(
                           user.uid,
                           nameController.text,
                           phoneController.text,
                           emailController.text,
                           addressController.text,
                           companyController.text,
                           downloadUrl,
                           selectedStartTime.value,
                           selectedEndTime.value,
                            _location,
                            _geoPosition,
                            fblink,
                           instalink);
                       isLoading.value = false;
                       Get.offNamed(Routes.VIEW_TRUCK);
                     }else{
                       isLoading.value = false;
                       Get.snackbar("Error", 'Something went wrong please try later',snackPosition: SnackPosition.BOTTOM);
                     }
                   }catch(error){
                     isLoading.value = false;
                     Get.snackbar("Error", 'Something went wrong please try later',snackPosition: SnackPosition.BOTTOM);
                   }
                 }
               }
             }
           }
         }

        }
      }
    }
    isLoading.value = false;
  }

  @override
  void onInit() async{
    getUserAddress();
    checkUserGps();
  }
}