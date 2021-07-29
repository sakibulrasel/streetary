import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
/**
 * Created by sakibul.haque on 14,July,2021
 */

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/core/model/truck_model.dart';
import 'package:streetary/data/img.dart';
import 'package:streetary/data/mycolor.dart';
import 'package:streetary/feature/new_menu/controller/new_menu_controller.dart';
class NewMenuScreen extends StatelessWidget {
  TextStyle textStyle = TextStyle(color: Colors.pink[800], height: 1.4, fontSize: 16);
  TextStyle labelStyle = TextStyle(color: Colors.pink[800]);
  UnderlineInputBorder lineStyle1 = UnderlineInputBorder(borderSide: BorderSide(color: (Colors.pink[800])!, width: 1));
  UnderlineInputBorder lineStyle2 = UnderlineInputBorder(borderSide: BorderSide(color: (Colors.pink[800])!, width: 2));
  final newMenucontroller = Get.find<NewMenuController>();
  // GlobalKey<TextFieldAutoCompleteState<String>> _textFieldAutoCompleteKey =
  // new GlobalKey(); // just copy paste this declaration.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text('Add New Menu'),
          backgroundColor: Colors.pink[800],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Obx(()=>newMenucontroller.isLoading.isTrue?
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
                newMenucontroller.saveMenu();
              },
            ),)
          ]
      ),
      body: GetX<NewMenuController>(
        init: Get.put<NewMenuController>(NewMenuController()),
          builder: (NewMenuController newMenuController){
            if(newMenuController!=null && newMenuController.trucks!=null&& newMenuController.trucks.length>0){
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: MyColors.grey_10,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Card(
                                  child: InkWell(
                                    onTap: (){
                                      newMenucontroller.getImage(ImageSource.gallery, 1);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 80,
                                      child: Obx(()=>newMenucontroller.firstImagePath.value==''?
                                      Icon(Icons.add_a_photo):
                                      Image.file(File(newMenucontroller.firstImagePath.value))),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: InkWell(
                                    onTap: (){
                                      newMenucontroller.getImage(ImageSource.gallery, 2);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 80,
                                      child: Obx(()=>newMenucontroller.secondImagePath.value==''?
                                      Icon(Icons.add_a_photo):
                                      Image.file(File(newMenucontroller.secondImagePath.value))),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: InkWell(
                                    onTap: (){
                                      newMenucontroller.getImage(ImageSource.gallery, 3);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 80,
                                      child: Obx(()=>newMenucontroller.thirdImagePath.value==''?
                                      Icon(Icons.add_a_photo):
                                      Image.file(File(newMenucontroller.thirdImagePath.value))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Card(
                                  child: InkWell(
                                    onTap: (){
                                      newMenucontroller.getImage(ImageSource.gallery, 4);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 80,
                                      child: Obx(()=>newMenucontroller.fourthImagePath.value==''?
                                      Icon(Icons.add_a_photo):
                                      Image.file(File(newMenucontroller.fourthImagePath.value))),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: InkWell(
                                    onTap: (){
                                      newMenucontroller.getImage(ImageSource.gallery, 5);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 80,
                                      child: Obx(()=>newMenucontroller.fifthImagePath.value==''?
                                      Icon(Icons.add_a_photo):
                                      Image.file(File(newMenucontroller.fifthImagePath.value))),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 80,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Obx(()=>newMenucontroller.isLoadTruck.isTrue?
                            Center(
                              child: CircularProgressIndicator(),
                            ):
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownSearch<TruckModel>(
                                label: "Select Truck",
                                onFind: (String filter) => newMenucontroller.getData(filter),
                                itemAsString: (TruckModel t) => t.getTruckName(),
                                onChanged: (data) {
                                  newMenucontroller.selectedtruck = data!;
                                },
                              ),
                              // child: TextFieldAutoComplete(
                              //     decoration: InputDecoration(
                              //       enabledBorder: new OutlineInputBorder(
                              //         borderSide: BorderSide(color: Colors.blue),
                              //       ),
                              //       focusedBorder: new OutlineInputBorder(
                              //         borderSide: BorderSide(color: Colors.black),
                              //       ),
                              //       labelText:
                              //       "Truck",
                              //       hintText:
                              //       "Truck",
                              //       floatingLabelBehavior: FloatingLabelBehavior.always,
                              //     ),
                              //     clearOnSubmit: false,
                              //     controller: newMenucontroller.truckController,
                              //     textSubmitted: (data) {
                              //       // print(data);
                              //       newMenucontroller.truckController.clear();
                              //     },
                              //     itemSubmitted: (String item) {
                              //       print('selected truck $item');
                              //       newMenucontroller.truck.value =item;
                              //       // _breed!.text = item;
                              //       // print('selected breed 2 ${_breed!.text}');
                              //     },
                              //     key: _textFieldAutoCompleteKey,
                              //     suggestions: newMenucontroller.truckListString,
                              //     itemBuilder: (context, String item) {
                              //       return Container(
                              //         padding: EdgeInsets.all(20),
                              //         child: Row(
                              //           children: [
                              //             Text(
                              //               item,
                              //               style: TextStyle(color: Colors.black),
                              //             )
                              //           ],
                              //         ),
                              //       );
                              //     },
                              //     itemSorter: (String a, String b) {
                              //       return a.compareTo(b);
                              //     },
                              //     itemFilter: (String item, query) {
                              //       return item
                              //           .toLowerCase()
                              //           .startsWith(query.toLowerCase());
                              //     }),
                            ),),

                            TextField(
                              controller: newMenuController.categoryController,
                              style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                              decoration: InputDecoration(
                                icon: Container(
                                    child: Icon(Icons.category, color: MyColors.grey_60),
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0)
                                ),
                                labelText: "Category", labelStyle: labelStyle,
                                enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                              ),
                            ),
                            Container(height: 10),
                            TextField(
                              controller: newMenuController.nameController,
                              style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                              decoration: InputDecoration(
                                icon: Container(child: Icon(Icons.title, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                                labelText: "Menu Title", labelStyle: labelStyle,
                                enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                              ),
                            ),
                            Container(height: 10),
                            TextField(
                              controller: newMenucontroller.priceController,
                              style: textStyle, keyboardType: TextInputType.number, cursorColor: Colors.pink[800],
                              decoration: InputDecoration(
                                icon: Container(child: Icon(Icons.monetization_on, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                                labelText: "Price", labelStyle: labelStyle,
                                enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                              ),
                            ),
                            Container(height: 10),
                            TextField(
                              maxLines: 2,
                              keyboardType: TextInputType.multiline,
                              controller: newMenucontroller.cuisineController,
                              style: textStyle, cursorColor: Colors.pink[800],
                              decoration: InputDecoration(
                                icon: Container(child: Icon(Icons.description, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                                labelText: "Cuisine", labelStyle: labelStyle,
                                enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                              ),
                            ),

                            Container(height: 10),
                          ],
                        ),
                      )
                    ],
                  )
              );
            }else{
              return Center(
                child: Text('Loading'),
              );
            }
          }
      )
    );
  }
}
