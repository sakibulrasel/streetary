import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:streetary/feature/kuzines/controller/kuzines_controller.dart';
import 'package:streetary/feature/menu/controller/menu_controller.dart';
import 'package:streetary/feature/rate_menu/controller/rate_menu_controller.dart';
class RateMenuTruckScreen extends StatelessWidget {
  late final String menuid;
  late final String ratecount;
  late final String rating;
  RateMenuTruckScreen(String menuid,String ratecount,String rating){
    this.menuid = menuid;
    this.ratecount= ratecount;
    this.rating = rating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate this Menu'),
      ),
      body: GetX<RateMenuController>(
        init: Get.put<RateMenuController>(RateMenuController()),
        builder: (RateMenuController ratemenuController){
          if(ratemenuController!=null){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: RatingBar.builder(
                    initialRating: ratemenuController.rating.value,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.favorite,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      ratemenuController.rating.value = rating;
                    },
                  ),
                ),
                Container(
                  height: 25,
                ),
                Center(
                  child: ElevatedButton(
                    child: Text('Submit'),
                    onPressed: (){
                      ratemenuController.rateMenuTruck(menuid, rating, ratecount);
                    },
                  ),
                )
              ],
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
