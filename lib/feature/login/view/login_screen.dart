import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/core/widget/custom_input_box.dart';
import 'package:streetary/core/widget/intter_clipped_part.dart';
import 'package:streetary/core/widget/outer_clipped_part.dart';
import 'package:streetary/feature/login/controller/login_controller.dart';
import 'package:streetary/routes/app_routes.dart';

import '../../profile/controller/profile_controller.dart';
class LoginScreen extends StatelessWidget {
  final loginController = Get.find<LoginController>();
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
                      'Sign In',
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


                SizedBox(
                  height: 70,
                ),
                //
                //
                SizedBox(
                  height: 30,
                ),
                //
                getCustomInputBox(
                  'Email',
                  'example@example.com',
                  loginController.emailController
                ),
                //
                SizedBox(
                  height: 30,
                ),
                //
                getCustomInputBox(
                  'Password',
                  '7+ Characters',
                  loginController.passwordController
                ),
                //
                SizedBox(
                  height: 30,
                ),
                //

                GestureDetector(
                  onTap: (){
                    if(loginController.isLoading.isFalse){
                      loginController.performLogin(profileController);
                    }
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
                      child: Obx(()=>loginController.isLoading.isTrue?
                      CircularProgressIndicator():
                      Text(
                        'Sign In',
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
                    Get.offAndToNamed(Routes.REGISTER);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Dont have an account? ',
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8f9db5).withOpacity(0.45),
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
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
