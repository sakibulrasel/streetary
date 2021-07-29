import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/core/widget/mytext.dart';
import 'package:streetary/data/img.dart';
import 'package:streetary/data/mycolor.dart';
import 'package:streetary/feature/user_profile/controller/user_profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: MyColors.primary,
          elevation: 0,
          title: Text("Profile"),

      ),
      body: GetX<UserProfileController>(
        init: Get.put<UserProfileController>(UserProfileController()),
        builder: (UserProfileController userProfileController){
          if(userProfileController!=null && userProfileController.userModel!=null && userProfileController.isLoading.isFalse){
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container( width: double.infinity, padding: EdgeInsets.all(20),
                    color: MyColors.primary,
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap:(){
                         userProfileController.getImage(ImageSource.gallery);
                          },
                          child: CircleAvatar(
                            radius: 52,
                            backgroundColor: Colors.white,
                            child: userProfileController.selectedImagePath!=''?
                            CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                FileImage(File(userProfileController.selectedImagePath.value))
                            )
                                :userProfileController.userModel.value.image==''?CircleAvatar(
                              radius: 50,
                              backgroundImage:
                              AssetImage(Img.get("no_profile_image.png"))
                            ):
                            CircleAvatar(
                                radius: 50,
                                backgroundImage:
                              NetworkImage(userProfileController.userModel.value.image),
                            ),
                          ),
                        ),
                        Container(height: 15),
                        Text(userProfileController.userModel.value.name, style: MyText.title(context)!.copyWith(color: Colors.white)),
                        Container(height: 5),
                        Text(userProfileController.userModel.value.email, style: MyText.subhead(context)!.copyWith(color: MyColors.grey_10)),
                        Container(height: 5),
                        userProfileController.selectedImagePath==''?Container():
                            Container(
                              child: userProfileController.isUploading.isFalse?ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green
                                ),
                                onPressed: (){
                                  userProfileController.updateProfileImage();
                                },
                                child: Text('Update'),
                              ):ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green
                                ),
                                onPressed: (){

                                },
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                      ],
                    ),
                  ),
                  Container(height: 20),
                  // Row(
                  //   children: <Widget>[
                  //     Expanded(
                  //       flex: 1,
                  //       child: Column(
                  //         children: <Widget>[
                  //           Text("1.5 K", style: MyText.title(context).copyWith(color: MyColors.grey_90)),
                  //           Container(height: 5),
                  //           Text("Posts", style: MyText.subhead(context).copyWith(color: MyColors.grey_60))
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: Column(
                  //         children: <Widget>[
                  //           Text("17.8 K", style: MyText.title(context).copyWith(color: MyColors.grey_90)),
                  //           Container(height: 5),
                  //           Text("Followers", style: MyText.subhead(context).copyWith(color: MyColors.grey_60))
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: Column(
                  //         children: <Widget>[
                  //           Text("1.3 K", style: MyText.title(context).copyWith(color: MyColors.grey_90)),
                  //           Container(height: 5),
                  //           Text("Following", style: MyText.subhead(context).copyWith(color: MyColors.grey_60))
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),


                ],
              ),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }
}
