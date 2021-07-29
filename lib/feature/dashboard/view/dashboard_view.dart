import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/feature/dashboard/controller/dashboard_controller.dart';

import '../../../core/widget/mytext.dart';
import '../../../data/img.dart';
import '../../../data/mycolor.dart';
import '../../../routes/app_routes.dart';
import '../../profile/controller/profile_controller.dart';
class DashboardScreen extends StatelessWidget {

  final dashboardController = Get.find<DashboardController>();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Vendor Dashboard'),
    //     actions: [
    //       Container(
    //         padding: EdgeInsets.only(right: 15),
    //           child: IconButton(
    //             icon: Icon(Icons.logout),
    //             onPressed: (){
    //               dashboardController.signOut(profileController);
    //             },
    //           )
    //       )
    //     ],
    //   ),
    //   body: Center(
    //     child: ElevatedButton(
    //       child: Text('Sign Out'),
    //       onPressed: (){
    //
    //       },
    //     ),
    //   ),
    // );
    return Scaffold(
        backgroundColor: MyColors.primary,
        appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: Container()),
        body: Obx((){
          return dashboardController.isLoading.isTrue?
          Center(
            child: CircularProgressIndicator(),
          ):
          Container(
            color: Colors.grey[100],
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        color: MyColors.primary,
                        width: double.infinity, height: 180,
                        child: Image.asset(Img.get('world_map.png'),fit: BoxFit.cover),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(height: 10),
                                Text("Hi, "+dashboardController.userModel.value.name, style: MyText.title(context)!.copyWith(color: Colors.white)),
                                Container(height: 5),
                                Text("Welcome to Streetary", style: MyText.caption(context)!.copyWith(color: Colors.grey[200]))
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              icon: const Icon(Icons.exit_to_app, color: Colors.white),
                              onPressed: () {
                                dashboardController.signOut(profileController);
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    transform: Matrix4.translationValues(0.0, -35.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4),),
                          color: Colors.white,
                          elevation: 2,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: 60,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Center(child: Text('Manage Truck and Menu',textAlign: TextAlign.center,)),
                          ),
                        ),
                        Container(height: 5),
                        Card(
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4)),
                          color: Colors.white,
                          elevation: 2,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        FloatingActionButton(heroTag: "fab1", elevation: 0, mini: true,
                                          backgroundColor: Colors.lightGreen[500], child: Icon(Icons.add_business_sharp, color: Colors.white,),
                                          onPressed: () {
                                          Get.toNamed(Routes.NEW_TRUCK);
                                          },
                                        ),
                                        Container(height: 5),
                                        Text("Add New Truck", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        FloatingActionButton(heroTag: "fab2", elevation: 0, mini: true,
                                          backgroundColor: Colors.blue, child: Icon(Icons.bus_alert, color: Colors.white,),
                                          onPressed: () {
                                              Get.toNamed(Routes.VIEW_TRUCK);
                                          },
                                        ),
                                        Container(height: 5),
                                        Text("View Truck", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        FloatingActionButton(heroTag: "fab3", elevation: 0, mini: true,
                                          backgroundColor: Colors.yellow[600], child: Icon(Icons.menu, color: Colors.white,),
                                          onPressed: () {
                                            Get.toNamed(Routes.NEW_MENU);
                                          },
                                        ),
                                        Container(height: 5),
                                        Text("Add New Menu", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        FloatingActionButton(heroTag: "fab4", elevation: 0, mini: true,
                                          backgroundColor: Colors.purple[400], child: Icon(Icons.description, color: Colors.white,),
                                          onPressed: () {
                                            Get.toNamed(Routes.VIEW_MENU);
                                          },
                                        ),
                                        Container(height: 5),
                                        Text("Menu List", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        })
    );
  }
}
