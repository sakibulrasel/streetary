/**
 * Created by sakibul.haque on 13,July,2021
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/core/widget/truck_list_item.dart';
import 'package:streetary/feature/edit_truck/view/edit_truck_view.dart';
import 'package:streetary/feature/view_truck/controller/view_truck_controller.dart';

class ViewTruckScreen extends StatelessWidget {
  const ViewTruckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trucks'),
      ),
      body: GetX<ViewTruckController>(
        init: Get.put<ViewTruckController>(ViewTruckController()),
        builder: (ViewTruckController viewTruckController){
          if(viewTruckController !=null && viewTruckController.trucks !=null){
            return Container(
              child: ListView.builder(
                itemBuilder: (ctx, index){
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(width: 20),
                          Container(
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(viewTruckController.trucks[index].image),
                              ),
                              width: 50,
                              height: 50
                          ),
                          Container(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    viewTruckController.trucks[index].name,
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.normal
                                    )
                                ),
                                Container(height: 5),
                                Text(
                                    'Email : '+viewTruckController.trucks[index].email,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.grey
                                    )

                                ),
                                Container(height: 5),
                                Text(
                                    'Phone '+viewTruckController.trucks[index].phone,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.grey
                                    )

                                ),
                                Container(height: 5),
                                Text(
                                    viewTruckController.trucks[index].address,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.grey
                                    )

                                ),
                                Divider(color: Colors.grey[300], height: 0),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.edit,color: Colors.green,),
                                    onPressed: (){
                                      print(viewTruckController.trucks[index].image);
                                      print(viewTruckController.trucks[index].image);
                                      Get.to(EditTruckScreen(viewTruckController.trucks[index]));
                                    }
                                ),
                                IconButton(
                                    icon: Icon(Icons.delete,color: Colors.red,),
                                    onPressed: (){
                                      Get.defaultDialog(
                                          title: 'Delete Truck',
                                          middleText: 'Are you Sure you Want to Delete This Truck',
                                          confirm: ElevatedButton(
                                              onPressed: (){
                                                viewTruckController.deleteTruck(viewTruckController.trucks[index].id, viewTruckController.trucks[index].image);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red
                                              ),
                                              child: Text('Confirm')
                                          ),
                                          cancel: ElevatedButton(
                                              onPressed: (){
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.amberAccent
                                              ),
                                              child: Text('Cancel')
                                          )
                                      );
                                    }
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
                itemCount: viewTruckController.trucks.length,
                padding: EdgeInsets.symmetric(vertical: 10),
              ),
            );
          }else{
            return Center(
              child: Text('Loading'),
            );
          }
        },
      ),
    );
  }
}
