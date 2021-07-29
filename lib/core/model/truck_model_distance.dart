/**
 * Created by sakibul.haque on 20,July,2021
 */

import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * Created by sakibul.haque on 13,July,2021
 */

class TruckModelDistance
{
  late String uid;
  late String id;
  late String name;
  late String phone;
  late String email;
  late String address;
  late String description;
  late String image;
  late String starttime;
  late String endtime;
  late String location;
  late GeoPoint geoPosition;
  late double distance;
  late String fblink;
  late String instalink;
  late List imagelist;
  late bool isFavorited;

  TruckModelDistance(this.uid,this.id, this.name, this.phone, this.email, this.address,
      this.description,this.image,this.starttime, this.endtime,this.location,this.geoPosition,
      this.distance,this.fblink,this.instalink,this.imagelist,this.isFavorited);

}