import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * Created by sakibul.haque on 13,July,2021
 */

class TruckModel
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
  late String fblink;
  late String instalink;
  late List imagelist;
  late List userList;

  TruckModel(this.uid,this.id, this.name, this.phone, this.email, this.address,
      this.description,this.image,this.starttime, this.endtime,this.location,
      this.geoPosition,this.fblink,this.instalink,this.imagelist,this.userList);

  TruckModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
  {
    id = documentSnapshot.id;
    uid = documentSnapshot['uid'];
    name = documentSnapshot['name'];
    phone = documentSnapshot['phone'];
    email = documentSnapshot['email'];
    address = documentSnapshot['address'];
    description = documentSnapshot['company'];
    image = documentSnapshot['image'];
    starttime = documentSnapshot['starttime'];
    endtime = documentSnapshot['endtime'];
    location = documentSnapshot['location'];
    geoPosition = documentSnapshot['geoposition'];
    fblink = documentSnapshot['fblink'];
    instalink = documentSnapshot['instalink'];
    imagelist = documentSnapshot['imagelist'];
    userList = documentSnapshot['userList'];
  }

  String getTruckName() {

    return name;
  }
}