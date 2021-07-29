import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streetary/core/model/truck_model.dart';

/**
 * Created by sakibul.haque on 14,July,2021
 */

class MenuModel
{
  late String uid;
  late String id;
  late String truckid;
  late String truckname;
  late String category;
  late String name;
  late String price;
  late String cuisine;
  late String firstimage;
  late String secondimage;
  late String thirdimage;
  late String fourthimage;
  late String fifthimage;
  late String location;
  late GeoPoint geoposition;
  late String rating;
  late String ratecount;
  late List userList;


  MenuModel(
      this.uid,
      this.id,
      this.truckid,
      this.truckname,
      this.category,
      this.name,
      this.price,
      this.cuisine,
      this.firstimage,
      this.secondimage,
      this.thirdimage,
      this.fourthimage,
      this.fifthimage,
      this.location,
      this.geoposition,
      this.rating,
      this.ratecount,
      this.userList);

  MenuModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
  {

    uid = documentSnapshot['uid'];
    id = documentSnapshot.id;
    truckid = documentSnapshot['truckid'];
    truckname = documentSnapshot['truckname'];
    category = documentSnapshot['category'];
    name = documentSnapshot['name'];
    price = documentSnapshot['price'];
    cuisine = documentSnapshot['cuisine'];
    firstimage = documentSnapshot['firstimage'];
    secondimage = documentSnapshot['secondimage'];
    thirdimage = documentSnapshot['thirdimage'];
    fourthimage = documentSnapshot['fourthimage'];
    fifthimage = documentSnapshot['fifthimage'];
    location = documentSnapshot['location'];
    geoposition = documentSnapshot['geoposition'];
    rating = documentSnapshot['rating'];
    ratecount = documentSnapshot['ratecount'];
    userList = documentSnapshot['userList'];
  }


}