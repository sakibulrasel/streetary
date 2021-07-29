import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/service/db_service.dart';

class AddTruckImageController extends GetxController
{


    Future<void>savePhoto(String truckId, File image, String caption) async
    {
      String captiontext='';
      if(caption.isNotEmpty){
        captiontext = caption;
      }
      return await DBService.instance.saveTruckImage(truckId, captiontext, image);
    }
}