import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/core/widget/mytext.dart';

import '../../../routes/app_routes.dart';
import '../controller/profile_controller.dart';
class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: GetX<ProfileController>(
        init: Get.put<ProfileController>(ProfileController()),
        builder: (ProfileController profileController){
          if(profileController!=null){
            return profileController.isLoggedin.isTrue?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  child: Text("Food Truck Owners", style: MyText.body1(context)!.copyWith(color: Colors.grey[500])),
                  margin: EdgeInsets.fromLTRB(15, 18, 15, 0),
                ),
                Card(
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0)),
                  elevation: 2,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 10),
                        InkWell(
                          onTap: (){
                            Get.toNamed(Routes.DASHBOARD);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.bus_alert, size: 25.0, color: Colors.grey[500]),
                                Container(width: 10),
                                Text("Manage My Truck", style: MyText.subhead(context)!.copyWith(
                                    color: Colors.grey[600], fontWeight: FontWeight.w500
                                )),
                                Spacer(),
                                Icon(Icons.chevron_right, size: 25.0, color: Colors.grey[500]),
                              ],
                            ),
                          ),
                        ),
                        Container(height: 10),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text("SETTINGS", style: MyText.body1(context)!.copyWith(color: Colors.grey[500])),
                  margin: EdgeInsets.fromLTRB(15, 18, 15, 0),
                ),
                Card(
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0)),
                  elevation: 2,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 10),
                        InkWell(
                          onTap: (){
                            Get.toNamed(Routes.USER_PROFILE);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.person, size: 25.0, color: Colors.grey[500]),
                                Container(width: 10),
                                Text("Account", style: MyText.subhead(context)!.copyWith(
                                    color: Colors.grey[600], fontWeight: FontWeight.w500
                                )),
                                Spacer(),
                                Icon(Icons.chevron_right, size: 25.0, color: Colors.grey[500]),
                              ],
                            ),
                          ),
                        ),
                        Container(height: 10),
                      ],
                    ),
                  ),
                ),

                Card(
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0)),
                  elevation: 2,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 10),
                        InkWell(
                          onTap: (){
                            profileController.signOut();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.exit_to_app, size: 25.0, color: Colors.grey[500]),
                                Container(width: 10),
                                Text("Logout", style: MyText.subhead(context)!.copyWith(
                                    color: Colors.grey[600], fontWeight: FontWeight.w500
                                )),
                                Spacer(),
                                Icon(Icons.chevron_right, size: 25.0, color: Colors.grey[500]),
                              ],
                            ),
                          ),
                        ),
                        Container(height: 10),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ):Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding:EdgeInsets.all(10),
                        child: Text(
                          'Login into Streetary will allow you to Favorite and Upload Pototos of trucks, Menu, Items and Hotspots',
                          style: TextStyle(
                          ),
                          textAlign: TextAlign.center,
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              Get.toNamed(Routes.LOGIN);
                            },
                            child: Container(
                                padding: EdgeInsets.only(left: 25,right: 25),
                                child: Text('Login')
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.amberAccent
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              Get.toNamed(Routes.REGISTER);
                            },
                            child: Container(
                                padding: EdgeInsets.only(left: 25,right: 25),
                                child: Text('Sign Up')
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
