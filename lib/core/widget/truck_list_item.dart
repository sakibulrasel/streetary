import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/core/model/truck_model.dart';
import 'package:streetary/feature/edit_truck/view/edit_truck_view.dart';

/**
 * Created by sakibul.haque on 13,July,2021
 */

getTruckListItem(TruckModel truckModel, int index)
{
    return Card(
      child: InkWell(
        onTap: (){
          // onItemClick(object);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(width: 20),
              Container(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(truckModel.image),
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
                      truckModel.name,
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.normal
                      )
                    ),
                    Container(height: 5),
                    Text(
                        'Email : '+truckModel.email,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.grey
                        )

                    ),
                    Container(height: 5),
                    Text(
                        'Phone '+truckModel.phone,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.grey
                        )

                    ),
                    Container(height: 5),
                    Text(
                        truckModel.address,
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
                          print(truckModel.image);
                          print(truckModel.image);
                          Get.to(EditTruckScreen(truckModel));
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
      ),
    );
}