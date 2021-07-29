import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/feature/kuzines/controller/kuzines_controller.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:streetary/feature/rate_menu/view/rate_menu_screen.dart';
class KuzinesScreen extends StatelessWidget {
  const KuzinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<KuzinesController>(
        init: Get.put<KuzinesController>(KuzinesController()),
        builder: (KuzinesController kuzinesController){
          if(kuzinesController!=null && kuzinesController.menuModel!=null && kuzinesController.isLoading.isFalse){
            return ListView.builder(
                itemCount: kuzinesController.menuModel.length,
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
                                                    kuzinesController.menuModel[index].firstimage,
                                                  width: double.infinity,
                                                  height: 200,
                                                  fit: BoxFit.fitWidth,
                                                )
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10,left: 15),
                                              child: Text(
                                                kuzinesController.menuModel[index].name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10,left: 15),
                                              child: Text(kuzinesController.menuModel[index].cuisine),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10,left: 15),
                                              child: Text(
                                                  kuzinesController.menuModel[index].price+' \$'
                                              ),
                                            ),


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
                                        kuzinesController.menuModel[index].name,
                                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        kuzinesController.menuModel[index].category,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        '\$ '+kuzinesController.menuModel[index].price,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: RatingStars(
                                        value: double.parse(kuzinesController.menuModel[index].rating),
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
                                  kuzinesController.menuModel[index].firstimage,
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
                            onPressed: () async{
                              User? user =  await FirebaseAuth.instance.currentUser;
                              if(user!=null){
                                Get.to(()=>RateMenuScreen(kuzinesController.menuModel[index].id,kuzinesController.menuModel[index].ratecount,kuzinesController.menuModel[index].rating,kuzinesController));

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
