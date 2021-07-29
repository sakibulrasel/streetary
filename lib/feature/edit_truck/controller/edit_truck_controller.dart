import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/core/model/truck_model.dart';
import 'package:streetary/service/location_service.dart';

import '../../../routes/app_routes.dart';
import '../../../service/cloud_storage_service.dart';
import '../../../service/db_service.dart';

/**
 * Created by sakibul.haque on 13,July,2021
 */

class EditTruckController extends GetxController
{
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var companyController = TextEditingController();
  var facebookController = TextEditingController();
  var instagramController = TextEditingController();

  UploadTask? task;
  RxBool isLoading = false.obs;
  RxString selectedStartTime =''.obs;
  RxString selectedEndTime =''.obs;

  late GeoPoint _geoPosition;
  late LocationPermission permission;
  late String _location;


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

  updateTruck(TruckModel truckModel) async
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
              if(truckModel.starttime.isEmpty && selectedStartTime.value==''){
                Get.snackbar("Opening Time", 'Please Select Your Truck Opening Time',snackPosition: SnackPosition.BOTTOM);
              }else{
                if(truckModel.endtime.isEmpty && selectedEndTime.value =='')
                  {
                    Get.snackbar("Closing Time", 'Please Select Your Truck Closing Time',snackPosition: SnackPosition.BOTTOM);
                  }else{
                  try{
                    String fblink='',instalink='';
                    if(facebookController.text.isNotEmpty){
                      fblink = facebookController.text;
                    }
                    if(instagramController.text.isNotEmpty){
                      instalink = instagramController.text;
                    }
                    isLoading.value = true;
                    User? user = await FirebaseAuth.instance.currentUser;

                    if(user!=null){
                      String starttime,endtime;
                      if(selectedStartTime.value==''){
                        starttime = truckModel.starttime;
                      }else{
                        starttime = selectedStartTime.value;
                      }
                      if(selectedEndTime.value==''){
                        endtime = truckModel.endtime;
                      }else{
                        endtime = selectedEndTime.value;
                      }
                      String downloadUrl;
                      if(selectedImagePath.value!=''){
                        var photoRef =
                        await FirebaseStorage.instance.refFromURL(truckModel.image);
                        photoRef.delete();
                        task = CloudStorageService.uploadFile('truck_images',File(selectedImagePath.value));
                        if(task == null) return;
                        final snapshot = await task!.whenComplete(() {});
                        downloadUrl = await snapshot.ref.getDownloadURL();
                      }else{
                        downloadUrl = truckModel.image;
                      }

                      DBService.instance.updateTruckInDB(
                          truckModel.id,
                          user.uid,
                          nameController.text,
                          phoneController.text,
                          emailController.text,
                          addressController.text,
                          companyController.text,
                          downloadUrl,
                          starttime,
                          endtime,
                        _location,
                        _geoPosition,
                        fblink,
                        instalink
                      );
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
    isLoading.value = false;
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

  @override
  void onInit() {
    checkUserGps();
    super.onInit();
  }
}