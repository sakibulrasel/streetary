/**
 * Created by sakibul.haque on 14,July,2021
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/feature/edit_menu/view/edit_menu_screen.dart';
import 'package:streetary/feature/view_menu/controller/view_menu_controller.dart';
class ViewMenuScreen extends StatelessWidget {
  const ViewMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: GetX<ViewMenuController>(
        init: Get.put<ViewMenuController>(ViewMenuController()),
        builder: (ViewMenuController viewMenuController){
          if(viewMenuController !=null && viewMenuController.menus !=null){
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
                                backgroundImage: NetworkImage(viewMenuController.menus[index].firstimage),
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
                                    viewMenuController.menus[index].name,
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.normal
                                    )
                                ),
                                Container(height: 5),
                                Text(
                                    'Truck : '+viewMenuController.menus[index].truckname,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.grey
                                    )

                                ),
                                Container(height: 5),
                                Text(
                                    'Price :  '+viewMenuController.menus[index].price+' \$',
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

                                      Get.to(EditMenuScreen(viewMenuController.menus[index]));
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
                                                viewMenuController.deleteMenu(viewMenuController.menus[index]);
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
                itemCount: viewMenuController.menus.length,
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
