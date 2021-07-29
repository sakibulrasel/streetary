import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/core/widget/custom_input_box.dart';
import 'package:streetary/core/widget/intter_clipped_part.dart';
import 'package:streetary/core/widget/new_button.dart';
import 'package:streetary/core/widget/outer_clipped_part.dart';
import 'package:streetary/data/img.dart';
import 'package:streetary/feature/register/controller/register_controller.dart';
import 'package:streetary/routes/app_routes.dart';

import '../../profile/controller/profile_controller.dart';
class RegisterScreen extends StatelessWidget {

  final registerController = Get.find<RegisterController>();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 40),
                    child: Text(
                      'Streetary',
                      style: TextStyle(
                        fontFamily: 'Cardo',
                        fontSize: 35,
                        color: Color(0xff0C2551),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    //
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, top: 5),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontFamily: 'Nunito Sans',
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                //
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: ()  {
                        registerController.getImage(ImageSource.gallery);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Obx(()=>registerController.selectedImagePath.value==''?
                      Image.asset(Img.get('no_profile_image.png'),fit: BoxFit.cover,width: 110.0,
                        height: 110.0,):
                      Image.file(File(registerController.selectedImagePath.value),fit: BoxFit.cover,width: 110.0,
                        height: 110.0,)),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text('Select Your Profile Photo'),
                ),
                SizedBox(
                  height: 30,
                ),
                //
                getCustomInputBox(
                 'Name',
                 'John',
                  registerController.nameController
                ),
                //
                SizedBox(
                  height: 30,
                ),
                //
                getCustomInputBox(
                  'Email',
                  'example@example.com',
                  registerController.emailController
                ),
                //
                SizedBox(
                  height: 30,
                ),
                //
                getCustomInputBox(
                  'Password',
                  '7+ Characters',
                  registerController.passwordController
                ),
                //
                SizedBox(
                  height: 10,
                ),

                GestureDetector(
                  onTap: ()
                  {
                    registerController.performRegistration(profileController);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: scrWidth * 0.80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff0962ff),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Obx(()=>registerController.isLoginComplete.isTrue?
                      CircularProgressIndicator():Text(
                        'Create an Account',
                        style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.offAndToNamed(Routes.LOGIN);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8f9db5).withOpacity(0.45),
                          ),
                        ),
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff90b7ff),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ClipPath(
              clipper: OuterClippedPart(),
              child: Container(
                color: Color(0xff0962ff),
                width: scrWidth,
                height: scrHeight,
              ),
            ),
            //
            ClipPath(
              clipper: InnerClippedPart(),
              child: Container(
                color: Color(0xff0c2551),
                width: scrWidth,
                height: scrHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
