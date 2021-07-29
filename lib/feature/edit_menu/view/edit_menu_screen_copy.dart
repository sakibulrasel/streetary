import 'dart:io';

/**
 * Created by sakibul.haque on 14,July,2021
 */
import 'package:flutter/material.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/core/model/menu_model.dart';
import 'package:streetary/data/mycolor.dart';
import 'package:streetary/feature/edit_menu/controller/edit_menu_controller.dart';
class EditMenuScreen extends StatelessWidget {
  final MenuModel menuModel;
  EditMenuScreen(this.menuModel);

  TextStyle textStyle = TextStyle(color: Colors.pink[800], height: 1.4, fontSize: 16);
  TextStyle labelStyle = TextStyle(color: Colors.pink[800]);
  UnderlineInputBorder lineStyle1 = UnderlineInputBorder(borderSide: BorderSide(color: (Colors.pink[800])!, width: 1));
  UnderlineInputBorder lineStyle2 = UnderlineInputBorder(borderSide: BorderSide(color: (Colors.pink[800])!, width: 2));
  final editMenucontroller = Get.find<EditMenuController>();
  GlobalKey<TextFieldAutoCompleteState<String>> _textFieldAutoCompleteKey =
  new GlobalKey(); // just copy paste this declaration.

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
            Obx(()=>editMenucontroller.isLoading.isTrue?
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
                // editMenucontroller.updateMenu(menuModel);
              },
            ),)
          ]
      ),
      body: GetX<EditMenuController>(
        init: Get.put<EditMenuController>(EditMenuController()),
        builder: (EditMenuController editController){
          if(editController !=null && editController.truck!=null){
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
                                    editMenucontroller.getImage(ImageSource.gallery, 1);
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 80,
                                    child: Obx(()=>editMenucontroller.firstImagePath.value==''?
                                    Image.network(menuModel.firstimage):
                                    Image.file(File(editMenucontroller.firstImagePath.value))),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: (){
                                    editMenucontroller.getImage(ImageSource.gallery, 2);
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 80,
                                    child: Obx(()=>editMenucontroller.secondImagePath.value==''?
                                    Image.network(menuModel.secondimage):
                                    Image.file(File(editMenucontroller.secondImagePath.value))),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: (){
                                    editMenucontroller.getImage(ImageSource.gallery, 3);
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 80,
                                    child: Obx(()=>editMenucontroller.thirdImagePath.value==''?
                                    Image.network(menuModel.thirdimage):
                                    Image.file(File(editMenucontroller.thirdImagePath.value))),
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
                                    editMenucontroller.getImage(ImageSource.gallery, 4);
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 80,
                                    child: Obx(()=>editMenucontroller.fourthImagePath.value==''?
                                    Image.network(menuModel.fourthimage):
                                    Image.file(File(editMenucontroller.fourthImagePath.value))),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: (){
                                    editMenucontroller.getImage(ImageSource.gallery, 5);
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 80,
                                    child: Obx(()=>editMenucontroller.fifthImagePath.value==''?
                                    Image.network(menuModel.fifthimage):
                                    Image.file(File(editMenucontroller.fifthImagePath.value))),
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
                          Obx(()=>editMenucontroller.isLoadTruck.isTrue?
                          Center(
                            child: CircularProgressIndicator(),
                          ):
                          Container(
                            height: 58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: TextFieldAutoComplete(
                                decoration: InputDecoration(
                                  enabledBorder: new OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelText:
                                  "Truck",
                                  hintText:
                                  "Truck",
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                ),
                                clearOnSubmit: false,
                                controller: editMenucontroller.truckController,
                                textSubmitted: (data) {
                                  // print(data);
                                  editMenucontroller.truckController.clear();
                                },
                                itemSubmitted: (String item) {
                                  print('selected truck $item');
                                  editMenucontroller.truck.value =item;
                                  // _breed!.text = item;
                                  // print('selected breed 2 ${_breed!.text}');
                                },
                                key: _textFieldAutoCompleteKey,
                                suggestions: editMenucontroller.truckListString,
                                itemBuilder: (context, String item) {
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Text(
                                          item,
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemSorter: (String a, String b) {
                                  return a.compareTo(b);
                                },
                                itemFilter: (String item, query) {
                                  return item
                                      .toLowerCase()
                                      .startsWith(query.toLowerCase());
                                }),
                          ),),

                          TextField(
                            controller: editMenucontroller.categoryController = TextEditingController(text: menuModel.category),
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
                            controller: editMenucontroller.nameController = TextEditingController(text: menuModel.name),
                            style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
                            decoration: InputDecoration(
                              icon: Container(child: Icon(Icons.title, color: MyColors.grey_60), margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                              labelText: "Menu Title", labelStyle: labelStyle,
                              enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                            ),
                          ),
                          Container(height: 10),
                          TextField(
                            controller: editMenucontroller.priceController = TextEditingController(text: menuModel.price),
                            style: textStyle, keyboardType: TextInputType.text, cursorColor: Colors.pink[800],
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
                            controller: editMenucontroller.cuisineController = TextEditingController(text: menuModel.cuisine),
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
        },
      ),
    );
  }
}
