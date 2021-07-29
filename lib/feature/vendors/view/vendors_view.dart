import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/feature/streateries_view/view/streateries_view_screen.dart';
import 'package:streetary/feature/vendors/controller/vendors_controller.dart';
class VendorsScreen extends StatelessWidget {
  const VendorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<VendorsController>(
        init: Get.put<VendorsController>(VendorsController()),
        builder: (VendorsController vendorsController){
          if(vendorsController !=null && vendorsController.truckModel !=null && vendorsController.isLoading.isFalse){

            return ListView.builder(
              itemBuilder: (ctx,index){
                return Card(
                  child: InkWell(
                    onTap: (){
                      Get.to(StreateriesViewScreen(vendorsController.truckModel[index]));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Image.network(vendorsController.truckModel[index].image,width: 80,height: 80,),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:EdgeInsets.only(left: 5),
                                    child: Text(
                                      vendorsController.truckModel[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:EdgeInsets.only(left: 5),
                                    child: Text(vendorsController.truckModel[index].email),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Icon(Icons.location_on_rounded),
                                        ),
                                        Container(
                                          child: Text(vendorsController.truckModel[index].address.contains(',')?
                                          vendorsController.truckModel[index].address.substring(0,vendorsController.trucks[index].address.indexOf(','))
                                              :vendorsController.truckModel[index].address)),
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
                                          child: Text(vendorsController.truckModel[index].starttime+ ' - '+ vendorsController.truckModel[index].endtime),
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
                          child: Icon(Icons.bus_alert),
                        )
                      ],
                    ),
                  ),
                );
                // return Text('${streateriesController.getDistanceBetween(streateriesController.geoPosition, streateriesController.trucks[index].geoPosition)} km');
              },
              itemCount: vendorsController.truckModel.length,
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
