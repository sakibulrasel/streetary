import 'dart:io';

/**
 * Created by sakibul.haque on 13,July,2021
 */
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/core/model/truck_model.dart';
import 'package:streetary/feature/edit_truck/controller/edit_truck_controller.dart';

import '../../../data/img.dart';
import '../../../data/mycolor.dart';
class EditTruckScreen extends StatelessWidget {
  final TruckModel truckModel;
  EditTruckScreen(this.truckModel);

  TextStyle textStyle = TextStyle(color: Colors.pink[800], height: 1.4, fontSize: 16);
  TextStyle labelStyle = TextStyle(color: Colors.pink[800]);
  UnderlineInputBorder lineStyle1 = UnderlineInputBorder(borderSide: BorderSide(color: (Colors.pink[800])!, width: 1));
  UnderlineInputBorder lineStyle2 = UnderlineInputBorder(borderSide: BorderSide(color: (Colors.pink[800])!, width: 2));
  final editTruckcontroller = Get.find<EditTruckController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text('Edit Truck'),
          backgroundColor: Colors.pink[800],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Obx(()=>editTruckcontroller.isLoading.isTrue?
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
                editTruckcontroller.updateTruck(truckModel);
              },
            ),)
          ]
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                height: 230, width: double.infinity,
                color: MyColors.grey_10,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Obx(()=>editTruckcontroller.selectedImagePath.value==''?
                      Image.network(truckModel.image):
                      Image.file(File(editTruckcontroller.selectedImagePath.value))),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, 40.0, 0.0),
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(heroTag: "fab3",
                        backgroundColor: Colors.blueGrey[800], elevation: 3,
                        child: Icon(Icons.photo_camera, color: Colors.white),
                        onPressed: () {
                          editTruckcontroller.getImage(ImageSource.gallery);
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
                      controller: editTruckcontroller.nameController= new TextEditingController(text: truckModel.name),
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
                      controller: editTruckcontroller.phoneController=new TextEditingController(text: truckModel.phone),
                      style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        icon: Container(child: Icon(Icons.phone, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: "Phone Number", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                    Container(height: 10),
                    TextField(
                      controller: editTruckcontroller.emailController= new TextEditingController(text: truckModel.email),
                      style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        icon: Container(child: Icon(Icons.email, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: "Email", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                    Container(height: 10),
                    TextField(
                      controller: editTruckcontroller.addressController= new TextEditingController(text: truckModel.address),
                      style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        icon: Container(child: Icon(Icons.location_on, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: "Address", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                    Container(height: 10),
                    TextField(
                      controller: editTruckcontroller.companyController= new TextEditingController(text: truckModel.description),
                      style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        icon: Container(child: Icon(Icons.description, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: "Description", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                    Container(height: 10),
                    TextField(
                      controller: editTruckcontroller.facebookController=new TextEditingController(text: truckModel.fblink),
                      style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        icon: Container(child: Icon(FontAwesomeIcons.facebook, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: "Facebook Link", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                    Container(height: 10),
                    TextField(
                      controller: editTruckcontroller.instagramController=new TextEditingController(text: truckModel.instalink),
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
                              editTruckcontroller.showStartTime(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green
                            ),
                            child: Obx(()=>editTruckcontroller.selectedStartTime.value==''?
                            Text(truckModel.starttime):
                            Text(editTruckcontroller.selectedStartTime.value)),
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: (){
                              editTruckcontroller.showEndTime(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.amber
                            ),
                            child: Obx(()=>editTruckcontroller.selectedEndTime.value==''?
                            Text(truckModel.endtime):
                            Text(editTruckcontroller.selectedEndTime.value)),
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
