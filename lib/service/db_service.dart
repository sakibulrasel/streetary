import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:streetary/core/model/image_with_caption.dart';
import 'package:streetary/core/model/menu_model.dart';
import 'package:streetary/core/model/truck_model.dart';
import 'package:streetary/service/cloud_storage_service.dart';

import '../core/model/user_model.dart';

class DBService{
  static DBService instance = DBService();
  late FirebaseFirestore _db;
  String _userCollection = "Users";
  String _truckCollection = "Truck";
  String _menuCollection = "Menu";
  String _imageCollection = "Images";

  UploadTask? task;

  DBService() {
    _db = FirebaseFirestore.instance;
  }


  Future<void> createUserInDB(
      String _uid, String _name,String email, String _imageURL,  String _location, GeoPoint _geoPosition) async {
    try {


      return await _db.collection(_userCollection).doc(_uid).set({
        "userId":_uid,
        "name": _name,
        "email": email,
        "image": _imageURL,
        "location": _location,
        "position": _geoPosition,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserInDB(
      String uid,String image
      ) async {
    try {
      return await _db.collection(_userCollection).doc(uid).update({
        "image":image,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveTruckInDB(
      String _uid, String _name,String phone, String email,
      String address, String company, String _imageURL,
      String starttime, String endtime,String _location, GeoPoint _geoPosition,
      String fblink, String instalink) async {
    try {
      return await _db.collection(_truckCollection).doc().set({
        "uid":_uid,
        "name":_name,
        "phone": phone,
        "email": email,
        "address": address,
        "company": company,
        "image": _imageURL,
        "starttime": starttime,
        "endtime": endtime,
        "location": _location,
        "geoposition": _geoPosition,
        "fblink":fblink,
        "instalink":instalink,
        "imagelist":[],
        "userList":[]
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveMenuInDB(
      String uid,String truckId,String truckname, String category,
      String name, String price, String cuisine,
      String firstimage, String secondimage,String thirdimage,
      String fourthimage, String fifthimage,String location, GeoPoint geoposition) async {
    try {
      return await _db.collection(_menuCollection).doc().set({
        "uid":uid,
        "truckid":truckId,
        "truckname":truckname,
        "category": category,
        "name": name,
        "price": price,
        "cuisine": cuisine,
        "firstimage": firstimage,
        "secondimage": secondimage,
        "thirdimage": thirdimage,
        "fourthimage": fourthimage,
        "fifthimage": fifthimage,
        "location": location,
        "geoposition": geoposition,
        "rating":"0",
        "ratecount":"0",
        "userList":[]
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateMenuInDB(
      String menuId,String uid,String truckId,String truckname, String category,
      String name, String price, String cuisine,
      String firstimage, String secondimage,String thirdimage,
      String fourthimage, String fifthimage
      ) async {
    try {
      return await _db.collection(_menuCollection).doc(menuId).update({
        "uid":uid,
        "truckid":truckId,
        "truckname":truckname,
        "category": category,
        "name": name,
        "price": price,
        "cuisine": cuisine,
        "firstimage": firstimage,
        "secondimage": secondimage,
        "thirdimage": thirdimage,
        "fourthimage": fourthimage,
        "fifthimage": fifthimage,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateRatingDB(
      String menuId,String rating,String ratecount
      ) async {
    try {
      return await _db.collection(_menuCollection).doc(menuId).update({
        "rating":rating,
        "ratecount":ratecount
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTruckInDB(String truckid,
      String _uid, String _name,String phone, String email,
      String address, String company, String _imageURL,
      String starttime, String endtime,String location, GeoPoint geoposition,
      String fblink, String instalink) async {
    try {
      return await _db.collection(_truckCollection).doc(truckid).update({
        "uid":_uid,
        "name":_name,
        "phone": phone,
        "email": email,
        "address": address,
        "company": company,
        "image": _imageURL,
        "starttime": starttime,
        "endtime": endtime,
        "location": location,
        "geoposition": geoposition,
        "fblink":fblink,
        "instalink":instalink
      });
    } catch (e) {
      print(e);
    }
  }
  
  Future<void> saveTruckImage(String truckId, String caption, File file) async
  {
    try{
      task = CloudStorageService.uploadFile('truck_user_images',file);
      if(task == null) return;
      final snapshot = await task!.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return await _db.collection(_truckCollection)
          .doc(truckId)
          .collection(_imageCollection)
          .doc().set({
          'caption':caption,
        'image':downloadUrl,
        'created_date':Timestamp.now()
      });
    }catch (error){
      print(error);
    }
  }

  Future<void> deleteTruckInDB(String truckid,String imageUrl) async {
    try {
      var photoRef =
      await FirebaseStorage.instance.refFromURL(imageUrl);
      await photoRef.delete();
      return await _db.collection(_truckCollection).doc(truckid).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteMenuInDB(MenuModel menuModel) async {
    try {
      if(menuModel.firstimage!=''){
        var photoRef =
        await FirebaseStorage.instance.refFromURL(menuModel.firstimage);
        await photoRef.delete();
      }
      if(menuModel.secondimage!=''){
        var photoRef =
        await FirebaseStorage.instance.refFromURL(menuModel.secondimage);
        await photoRef.delete();
      }
      if(menuModel.thirdimage!=''){
        var photoRef =
        await FirebaseStorage.instance.refFromURL(menuModel.thirdimage);
        await photoRef.delete();
      }
      if(menuModel.fourthimage!=''){
        var photoRef =
        await FirebaseStorage.instance.refFromURL(menuModel.fourthimage);
        await photoRef.delete();
      }
      if(menuModel.fifthimage!=''){
        var photoRef =
        await FirebaseStorage.instance.refFromURL(menuModel.fifthimage);
        await photoRef.delete();
      }

      return await _db.collection(_menuCollection).doc(menuModel.id).delete();
    } catch (e) {
      print(e);
    }
  }


  Stream<List<TruckModel>> truckStream(String uid) {
    return _db
        .collection(_truckCollection)
        .where('uid',isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TruckModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(TruckModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }
  

  Stream<List<ImageWithCaption>> truckImage(String truckid) {
    return _db
        .collection(_truckCollection)
        .doc(truckid)
        .collection(_imageCollection)
        .orderBy('created_date',descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ImageWithCaption> retVal = [];
      query.docs.forEach((element) {
        retVal.add(new ImageWithCaption(element.id, element['caption'], element['image'],element['created_date']));
      });
      return retVal;
    });
  }

  Stream<List<MenuModel>> menuStream(String uid) {
    return _db
        .collection(_menuCollection)
        .where('uid',isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<MenuModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(MenuModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<MenuModel>> getMenu(String truckid) {
    return _db
        .collection(_menuCollection)
        .where('truckid',isEqualTo: truckid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<MenuModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(MenuModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<TruckModel>> getFavouriteTruck(String uid) {
    return _db
        .collection(_truckCollection)
        .where('userList',arrayContains: uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TruckModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(TruckModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }



  Future<List<String>> gettruckStream(String uid) async{
    List<String> truckList=[];
    _db.collection(_truckCollection)
    .where('uid',isEqualTo: uid)
    .get()
    .then((value) => {
      value.docs.forEach((element) {
        truckList.add(element['name']);
      })
    });
   return truckList;
  }

  Future<List<MenuModel>> getAllMenu() async {

    List<MenuModel> menuList=[];
    await _db
        .collection(_menuCollection)
        .get()
        .then((value) => {
          value.docs.forEach((element) {
            menuList.add(new MenuModel(
                element['uid'], element.id, element['truckid'],element['truckname'],
                element['category'],element['name'],element['price'],element['cuisine'],
                element['firstimage'],element['secondimage'],element['thirdimage'],
                element['fourthimage'],element['fifthimage'],element['location'],
                element['geoposition'],element['rating'],element['ratecount'],
            element['userList']));
          })
    });
    return menuList;
  }

  Future<List<TruckModel>> getAllTruck() async{
    List<TruckModel> truckList=[];
   await _db.collection(_truckCollection)
        .get()
        .then((value) => {
      value.docs.forEach((element) {
        truckList.add(new TruckModel(element['uid'], element.id, element['name'], element['phone'],
            element['email'], element['address'], element['company'],
            element['image'], element['starttime'], element['endtime'],
            element['location'], element['geoposition'],element['fblink'],
            element['instalink'],element['imagelist'],element['userList']));
      })
    });
    return truckList;
  }

  Future<List<TruckModel>> getAllFavouruteTruck(String uid) async{
    List<TruckModel> truckList=[];
    await _db.collection(_truckCollection)
        .where('userList',arrayContains: uid)
        .get()
        .then((value) => {
      value.docs.forEach((element) {
        truckList.add(new TruckModel(element['uid'], element.id, element['name'], element['phone'],
            element['email'], element['address'], element['company'],
            element['image'], element['starttime'], element['endtime'],
            element['location'], element['geoposition'],element['fblink'],
            element['instalink'],element['imagelist'],element['userList']));
      })
    });
    return truckList;
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
      await _db.collection(_userCollection).doc(uid).get();

      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<TruckModel> getTruck(String truckid) async {
    try {
      DocumentSnapshot _doc =
      await _db.collection(_truckCollection).doc(truckid).get();

      return TruckModel.fromDocumentSnapshot( _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> markAsFavorite(String truckid,String uid) async
  {
    await _db.collection(_truckCollection).doc(truckid).update({
      'userList': FieldValue.arrayUnion([uid])
    });
  }

  Future<void> removeFavorite(String truckid,String uid) async
  {
    await _db.collection(_truckCollection).doc(truckid).update({
      'userList': FieldValue.arrayRemove([uid])
    });
  }
}