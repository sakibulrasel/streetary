import 'dart:io';

/**
 * Created by sakibul.haque on 12,July,2021
 */
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/feature/new_truck/controller/new_truck_controller.dart';

import '../../../data/img.dart';
import '../../../data/mycolor.dart';
class NewTrcukScreen extends StatelessWidget {
  TextStyle textStyle = TextStyle(color: Colors.pink[800], height: 1.4, fontSize: 16);
  TextStyle labelStyle = TextStyle(color: Colors.pink[800]);
  UnderlineInputBorder lineStyle1 = UnderlineInputBorder(borderSide: BorderSide(color: (Colors.pink[800])!, width: 1));
  UnderlineInputBorder lineStyle2 = UnderlineInputBorder(borderSide: BorderSide(color: (Colors.pink[800])!, width: 2));
  final newTruckcontroller = Get.find<NewTruckController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add New Truck'),
          backgroundColor: Colors.pink[800],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Obx(()=>newTruckcontroller.isLoading.isTrue?
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ):
            IconButton(
              icon: Icon(Icons.done),
              onPressed: ()
              {
                newTruckcontroller.saveTruck();
              },
            ),)
          ]
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                height: 150, width: double.infinity,
                color: MyColors.grey_10,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Obx(()=>newTruckcontroller.selectedImagePath.value==''?
                      Image.asset(Img.get('truck.jpg'),fit: BoxFit.fitWidth,):
                      Image.file(File(newTruckcontroller.selectedImagePath.value))),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, 40.0, 0.0),
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(heroTag: "fab3",
                        backgroundColor: Colors.blueGrey[800], elevation: 3,
                        child: Icon(Icons.photo_camera, color: Colors.white),
                        onPressed: () {
                          newTruckcontroller.getImage(ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: newTruckcontroller.nameController,
                      style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        icon: Container(
                            child: Icon(Icons.person, color: MyColors.grey_60),
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 0)
                        ),
                        labelText: "Name", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                    Container(height: 10),
                    TextField(
                      controller: newTruckcontroller.phoneController,
                      style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        icon: Container(child: Icon(Icons.phone, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: "Phone Number", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                    Container(height: 10),
                    TextField(
                      controller: newTruckcontroller.emailController,
                      style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        icon: Container(child: Icon(Icons.email, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: "Email", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                    Container(height: 10),
                    Obx((){
                      return newTruckcontroller.addressLine.value!=''?
                      TextField(
                        controller: newTruckcontroller.addressController= new TextEditingController(
                            text: newTruckcontroller.addressLine.value,
                        ),

                        style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              newTruckcontroller.addressLine.value='';
                              newTruckcontroller.addressController.clear();
                            } ,
                            icon: Icon(Icons.clear),
                          ),
                          icon: Container(child: Icon(Icons.location_on, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                          labelText: "Address", labelStyle: labelStyle,
                          enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                        ),
                      ):
                      TextField(
                        controller: newTruckcontroller.addressController,
                        style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                        decoration: InputDecoration(
                          icon: Container(child: Icon(Icons.location_on, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                          labelText: "Address", labelStyle: labelStyle,
                          enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                        ),
                      );
                    }),
                    Container(height: 10),
                    TextField(
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      controller: newTruckcontroller.companyController,
                      style: textStyle, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        icon: Container(child: Icon(Icons.description, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: "Description", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                    Container(height: 10),
                    TextField(
                      controller: newTruckcontroller.facebookController,
                      style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        icon: Container(child: Icon(FontAwesomeIcons.facebook, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: "Facebook Link", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                    Container(height: 10),
                    TextField(
                      controller: newTruckcontroller.instagramController,
                      style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        icon: Container(child: Icon(FontAwesomeIcons.instagram, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: "Instagram Link", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                    Container(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: ElevatedButton(
                            onPressed: ()
                            {
                             newTruckcontroller.showStartTime(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green
                            ),
                            child: Obx(()=>newTruckcontroller.selectedStartTime.value==''?
                            Text('Start Time'):
                            Text(newTruckcontroller.selectedStartTime.value)),
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: (){
                              newTruckcontroller.showEndTime(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.amber
                            ),
                            child: Obx(()=>newTruckcontroller.selectedEndTime.value==''?
                            Text('End Time'):
                            Text(newTruckcontroller.selectedEndTime.value)),
                          ),
                        )
                      ],
                    ),

                    Container(height: 10),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
