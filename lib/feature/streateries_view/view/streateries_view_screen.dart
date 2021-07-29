/**
 * Created by sakibul.haque on 20,July,2021
 */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streetary/core/model/truck_model_distance.dart';
import 'package:streetary/core/widget/mytext.dart';
import 'package:streetary/data/img.dart';
import 'package:streetary/data/mycolor.dart';
import 'package:streetary/feature/menu/view/menu_screen.dart';
import 'package:streetary/feature/streateries_view/controller/streateries_view_controller.dart';
import 'package:streetary/feature/web_view/view/web_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';
class StreateriesViewScreen extends StatelessWidget {
  final TruckModelDistance truckModelDistance;
  StreateriesViewScreen(this.truckModelDistance);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 250.0,
                floating: true, pinned: true,
                title: Text(truckModelDistance.name),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Image.network(truckModelDistance.image,fit: BoxFit.fitWidth),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {Navigator.pop(context); },
                ),
              ),
            ];
          },
          body: GetX<StreateriesViewController>(
            init: Get.put<StreateriesViewController>(StreateriesViewController(truckModelDistance.id)),
            builder: (StreateriesViewController streateriesviewController){
              if(streateriesviewController!=null && streateriesviewController.images!=null&& streateriesviewController.isTruckLoading.isFalse){
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(streateriesviewController.truckModel.value.name, style: MyText.headline(context)!.copyWith(
                            color: MyColors.grey_90, fontWeight: FontWeight.bold
                        )),
                        Container(height: 5),
                        Text(streateriesviewController.truckModel.value.address, style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_40,
                        )),
                        Divider(),
                        Text("Description", style: MyText.medium(context).copyWith(
                            color: MyColors.grey_90, fontWeight: FontWeight.bold
                        )),
                        Container(height: 5),
                        Text(streateriesviewController.truckModel.value.description, textAlign: TextAlign.justify, style:TextStyle(
                            color: Colors.grey
                        )),
                        Container(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: (){
                                if(streateriesviewController.truckModelDistance.value.isFavorited)
                                {
                                  print('remove from favorite');
                                  streateriesviewController.removeFavorite(truckModelDistance.id, streateriesviewController.userid.value);
                                }else{
                                  streateriesviewController.markAsFavorite(truckModelDistance.id, streateriesviewController.userid.value);
                                }
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    streateriesviewController.truckModelDistance.value.isFavorited?
                                    Icon(Icons.star):
                                    Icon(Icons.star_border),
                                    streateriesviewController.truckModelDistance.value.isFavorited?Text('Favorited'):
                                        Text('Favorite')
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                streateriesviewController.openDialog(streateriesviewController.truckModel.value.id);
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Icon(Icons.camera_alt),
                                    Text('Add Photo')
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        Container(height: 10),
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:EdgeInsets.only(bottom: 10),
                                child: Text('Photo',style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 110,
                                    width: MediaQuery.of(context).size.width/1.2,
                                    child: ListView.builder(
                                      itemCount: streateriesviewController.images.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (ctx,index){
                                          return Container(
                                            padding: EdgeInsets.all(5),
                                                    margin: EdgeInsets.only(left: 5),
                                                    height: 100,
                                                    width: 100,
                                                    decoration: new BoxDecoration(
                                                        border: Border.all(color: Colors.black),
                                                        image: new DecorationImage(
                                                            image: new NetworkImage(
                                                                streateriesviewController.images[index].image),
                                                            fit: BoxFit.fill)));

                                        }
                                    )
                                  ),
                                  // InkWell(
                                  //   onTap: (){
                                  //     streateriesviewController.openDialog(truckModelDistance.id);
                                  //   },
                                  //   child: Container(
                                  //     padding: EdgeInsets.only(right: 15),
                                  //     child: Icon(Icons.camera_alt),
                                  //   ),
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(height: 10),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Info',style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: (){
                                    Get.to(()=>MenuScreen(truckModelDistance));
                                  },
                                  child: ListTile(
                                    title: Text('Menu'),
                                    leading: Icon(Icons.restaurant_menu,color: Colors.black,),
                                    trailing: Icon(Icons.navigate_next),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: (){
                                    launch('tel:${streateriesviewController.truckModel.value.phone}');
                                  },
                                  child: ListTile(
                                    title: Text(streateriesviewController.truckModel.value.phone),
                                    leading: Icon(Icons.local_phone,color: Colors.black,),
                                    trailing: Icon(Icons.navigate_next),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: (){
                                      Get.to(()=>WebViewScreen(streateriesviewController.truckModel.value.fblink));
                                  },
                                  child: ListTile(
                                    title: Text(streateriesviewController.truckModel.value.fblink),
                                    leading: Icon(FontAwesomeIcons.facebook,color: Colors.black,),
                                    trailing: Icon(Icons.navigate_next),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: (){
                                    Get.to(()=>WebViewScreen(streateriesviewController.truckModel.value.instalink));
                                  },
                                  child: ListTile(
                                    title: Text(streateriesviewController.truckModel.value.instalink),
                                    leading: Icon(FontAwesomeIcons.instagram,color: Colors.black,),
                                    trailing: Icon(Icons.navigate_next),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
