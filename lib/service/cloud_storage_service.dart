import 'dart:io';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {

 static UploadTask? uploadFile(String path, File _image){
  try {
    String fileName = basename(_image.path);
    final ref =  FirebaseStorage.instance.ref()
        .child(path+'/$fileName');
    return ref.putFile(_image);

  } catch (e) {
    print(e);
    return null;
  }
}

}