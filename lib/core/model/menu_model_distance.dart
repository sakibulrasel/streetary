import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * Created by sakibul.haque on 14,July,2021
 */

class MenuModelDistance
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
  late double distance;
  late String rating;
  late String ratecount;


  MenuModelDistance(
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
      this.distance,
      this.rating,
      this.ratecount);
}