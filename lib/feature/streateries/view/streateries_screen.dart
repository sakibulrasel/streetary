import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/feature/streateries/controller/streateries_controller.dart';
import 'package:streetary/feature/streateries_view/view/streateries_view_screen.dart';
import 'package:streetary/routes/app_routes.dart';
class StreateriesScreen extends StatelessWidget {
  // final streateriesController = Get.find<StreateriesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<StreateriesController>(
        init: Get.put<StreateriesController>(StreateriesController()),
        builder: (StreateriesController streateriesController){
          if(streateriesController !=null && streateriesController.truckModel !=null && streateriesController.isLoading.isFalse){

            return ListView.builder(
                itemBuilder: (ctx,index){
                  return Card(
                    child: InkWell(
                      onTap: (){
                        Get.to(StreateriesViewScreen(streateriesController.truckModel[index]));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Row(
                           children: [
                             Container(
                               padding: EdgeInsets.all(10),
                               child: Image.network(streateriesController.truckModel[index].image,width: 80,height: 80,),
                             ),
                             Container(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   Container(
                                     padding:EdgeInsets.only(left: 5),
                                     child: Text(
                                       streateriesController.truckModel[index].name,
                                       style: TextStyle(
                                           fontWeight: FontWeight.bold
                                       ),
                                     ),
                                   ),
                                   Container(
                                     padding:EdgeInsets.only(left: 5),
                                     child: Text(streateriesController.truckModel[index].email),
                                   ),
                                   Container(
                                     child: Row(
                                       children: [
                                         Container(
                                           child: Icon(Icons.location_on_rounded),
                                         ),
                                         Container(
                                             width: MediaQuery.of(context).size.width/2,
                                           child:
                                           Text(streateriesController.truckModel[index].address)
                                         )
                                       ],
                                     ),
                                   ),
                                   Container(
                                     child: Row(
                                       children: [
                                         Container(
                                           child: Icon(Icons.access_time_outlined),
                                         ),
                                         Container(
                                           child: Text(streateriesController.truckModel[index].starttime+ ' - '+ streateriesController.truckModel[index].endtime),
                                         )
                                       ],
                                     ),
                                   )
                                 ],
                               ),
                             ),
                           ],
                         ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Text('${streateriesController.truckModel[index].distance} mi'),
                          )
                        ],
                      ),
                    ),
                  );
                  // return Text('${streateriesController.getDistanceBetween(streateriesController.geoPosition, streateriesController.trucks[index].geoPosition)} km');
                },
                itemCount: streateriesController.truckModel.length,
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
