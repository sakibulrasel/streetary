
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/feature/favourite/controller/favorite_controller.dart';
import 'package:streetary/feature/streateries_view/view/streateries_view_screen.dart';
class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<FavouriteController>(
        init: Get.put<FavouriteController>(FavouriteController()),
        builder: (FavouriteController favouriteController){
          if(favouriteController!=null&& favouriteController.trucks!=null&& favouriteController.trucks.length>0){
            return RefreshIndicator(
              onRefresh: ()async{
                favouriteController.getData();
              },
              child: Container(
                child: ListView.builder(
                  itemBuilder: (ctx,index){
                    return Card(
                      child: InkWell(
                        onTap: (){
                          Get.to(StreateriesViewScreen(favouriteController.truckModel[index]));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Image.network(favouriteController.truckModel[index].image,width: 80,height: 80,),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:EdgeInsets.only(left: 5),
                                        child: Text(
                                          favouriteController.truckModel[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:EdgeInsets.only(left: 5),
                                        child: Text(favouriteController.truckModel[index].email),
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
                                                Text(favouriteController.truckModel[index].address))

                                            // Text(streateriesController.truckModel[index].address.substring(0,streateriesController.trucks[index].address.indexOf(','))),
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
                                              child: Text(favouriteController.truckModel[index].starttime+ ' - '+ favouriteController.truckModel[index].endtime),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: (){
                                      favouriteController.removeFavorite(favouriteController.truckModel[index].id);
                                    },
                                    icon: Icon(Icons.remove,color: Colors.red,)
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15,top: 5),
                                  child: Text('${favouriteController.truckModel[index].distance} mi'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                    // return Text('${streateriesController.getDistanceBetween(streateriesController.geoPosition, streateriesController.trucks[index].geoPosition)} km');
                  },
                  itemCount: favouriteController.truckModel.length,
                ),
              ),
            );
          }else{
            if(favouriteController!=null){
              return favouriteController.isLogin.isTrue?Center(
                child: favouriteController.isLoading.isTrue?CircularProgressIndicator():
                RefreshIndicator(
                  onRefresh: ()async{
                    favouriteController.getData();
                  },
                  child: Center(
                    child: Text('There is no Favourite Item'),
                  ),
                ),
              ):RefreshIndicator(
                onRefresh: ()async{
                  favouriteController.getData();
                },
                child: Center(
                  child: Text("Please login First to See Your favourite List"),
                ),
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }
}
