import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/routes/app_routes.dart';

import '../../profile/controller/profile_controller.dart';

class LoginController extends GetxController
{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  performLogin(ProfileController controller) async
  {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text);
    if(emailController.text.isEmpty|| !emailValid){
      Get.snackbar("Email", 'Please Enter a Valid Email',snackPosition: SnackPosition.BOTTOM);
    }else{
      if(passwordController.text.isEmpty||passwordController.text.length<8){
        Get.snackbar("Password", 'Password Must Me Greater than 7 Character',snackPosition: SnackPosition.BOTTOM);
      }else{
        try{
          isLoading.value = true;
          User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text)).user;
          if(user!=null){
            isLoading.value = false;
            controller.checkLoginStatus();
            Get.offAndToNamed(Routes.DASHBOARD);
          }else{
            isLoading.value = false;
            Get.snackbar("Invalid", 'User name and Password doesnot match',snackPosition: SnackPosition.BOTTOM);
          }
        }catch(error){
          isLoading.value = false;
          Get.snackbar("Invalid", 'User name and Password doesnot match',snackPosition: SnackPosition.BOTTOM);
        }
      }
    }
    isLoading.value = false;
  }
}