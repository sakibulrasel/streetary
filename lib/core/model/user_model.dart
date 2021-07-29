import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel
{
  late String uid;
  late String name;
  late String email;
  late String image;
  late String userId;
  late String location;
  late GeoPoint position;

  UserModel(this.uid, this.name,this.email, this.image,this.userId,this.location,this.position);
  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    image = documentSnapshot["image"];
    userId = documentSnapshot["userId"];
    location = documentSnapshot["location"];
    position = documentSnapshot["position"];
  }
}