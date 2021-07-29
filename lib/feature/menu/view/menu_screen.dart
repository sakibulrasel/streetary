import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:streetary/core/model/truck_model_distance.dart';
import 'package:streetary/feature/menu/controller/menu_controller.dart';
import 'package:streetary/feature/rate_menu_truck/view/rate_menu_screen.dart';
class MenuScreen extends StatelessWidget {

  late final TruckModelDistance truckModelDistance;
  MenuScreen(TruckModelDistance truckModelDistance)
  {
    this.truckModelDistance = truckModelDistance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(truckModelDistance.name),
      ),
      body: GetX<MenuController>(
        init: Get.put<MenuController>(MenuController(truckModelDistance)),
        builder: (MenuController menuController){
          if(menuController!=null && menuController.menus!=null){
            return ListView.builder(
              itemCount: menuController.menus.length,
                itemBuilder: (ctx,index){
                  return Card(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            showModalBottomSheet(
                                context: context,
                                builder: (builder){
                                  return new Container(
                                    height: MediaQuery.of(context).size.height/1.2,
                                    color: Colors.transparent, //could change this to Color(0xFF737373),
                                    //so you don't have to change MaterialApp canvasColor
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.only(
                                                topLeft: const Radius.circular(20.0),
                                                topRight: const Radius.circular(20.0))),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Image.network(
                                                  menuController.menus[index].firstimage,
                                                  width: double.infinity,height: 200,
                                                  fit: BoxFit.fitWidth,)
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10,left: 15),
                                              child: Text(
                                                menuController.menus[index].name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10,left: 15),
                                              child: Text(menuController.menus[index].cuisine),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10,left: 15),
                                              child: Text(
                                                  menuController.menus[index].price+' \$'
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                }
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10,left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                          menuController.menus[index].name,
                                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        menuController.menus[index].category,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        '\$ '+menuController.menus[index].price,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: RatingStars(
                                        value: double.parse(menuController.menus[index].rating),
                                        onValueChanged: (v) {
                                          print(v);
                                        },
                                        starBuilder: (index, color) => Icon(
                                          Icons.favorite,
                                          color: color,
                                        ),
                                        starCount: 5,
                                        starSize: 20,
                                        valueLabelColor: const Color(0xff9b9b9b),
                                        valueLabelTextStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12.0),
                                        valueLabelRadius: 10,
                                        maxValue: 5,
                                        starSpacing: 2,
                                        maxValueVisibility: true,
                                        valueLabelVisibility: true,
                                        animationDuration: Duration(milliseconds: 1000),
                                        valueLabelPadding:
                                        const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                                        valueLabelMargin: const EdgeInsets.only(right: 8),
                                        starOffColor: const Color(0xffe7e8ea),
                                        starColor: Colors.yellow,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Image.network(
                                  menuController.menus[index].firstimage,
                                  width: 100,height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            child: Text('Rate this Menu'),
                            onPressed: ()async{
                              User? user =  await FirebaseAuth.instance.currentUser;
                              if(user!=null){
                                Get.to(()=>RateMenuTruckScreen(menuController.menus[index].id, menuController.menus[index].ratecount, menuController.menus[index].rating));

                              }else{
                                Get.snackbar('Login', 'You Have to Login first to rate this menu');

                              }
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }
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
