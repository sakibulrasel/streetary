import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/data/mycolor.dart';
import 'package:streetary/feature/add_truck_image/controller/add_truck_image_controller.dart';
import 'package:streetary/service/db_service.dart';

class AddTruckImageScreen extends StatelessWidget {
  late File image;
  late String truckid;
  AddTruckImageScreen(File file,String truckid){
    this.image = file;
    this.truckid = truckid;
  }
  TextStyle textStyle = TextStyle(color: Colors.pink[800], height: 1.4, fontSize: 16);
  TextStyle labelStyle = TextStyle(color: Colors.pink[800]);
  UnderlineInputBorder lineStyle1 = UnderlineInputBorder(borderSide: BorderSide(color: (Colors.pink[800])!, width: 1));
  UnderlineInputBorder lineStyle2 = UnderlineInputBorder(borderSide: BorderSide(color: (Colors.pink[800])!, width: 2));
  var captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Photo'),
        actions: [
          TextButton(
            child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'Upload',
                  style: TextStyle(color: Colors.white),
                )
            ),
            onPressed: (){
              DBService.instance.saveTruckImage(truckid, captionController.text.isNotEmpty?captionController.text:'', image).then((value) => Get.back());
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    child: Image.file(image,width: MediaQuery.of(context).size.width/3,height: MediaQuery.of(context).size.width/3,fit: BoxFit.cover,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width/1.9,
                    child: TextField(
                      controller: captionController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      style: textStyle, cursorColor: Colors.pink[800],
                      decoration: InputDecoration(
                        labelText: "Caption", labelStyle: labelStyle,
                        enabledBorder: lineStyle1, focusedBorder: lineStyle2,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
