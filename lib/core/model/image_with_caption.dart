import 'package:cloud_firestore/cloud_firestore.dart';

class ImageWithCaption{
  late String id;
  late String caption;
  late String image;
  late Timestamp created_date;

  ImageWithCaption(this.id, this.caption, this.image,this.created_date);

  ImageWithCaption.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
  {
    id = documentSnapshot.id;
    caption = documentSnapshot['caption'];
    image = documentSnapshot['image'];
    created_date = documentSnapshot['created_date'];
  }
}