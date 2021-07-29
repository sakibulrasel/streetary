import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';
import 'package:streetary/core/model/truck_model.dart';
import 'package:streetary/core/model/truck_model_distance.dart';
import 'package:streetary/service/db_service.dart';
import 'package:streetary/service/location_service.dart';

class FavouriteController extends GetxController
{
  RxBool isLoading = false.obs;
  RxBool isLogin = false.obs;
  late GeoPoint geoPosition;
  late Rx<double> distanceBetween=Rx<double>(0);
  late LocationPermission permission;

  RxList<TruckModel> truckList = RxList<TruckModel>();

  List<TruckModel> get trucks => truckList.value;

  RxList<TruckModelDistance> truckmodelDistanceList = RxList<TruckModelDistance>();
  List<TruckModelDistance> get truckModel => truckmodelDistanceList.value;

  double getDistanceBetween(GeoPoint point1, GeoPoint point2, {int method = 2}) {
    var gcd = new GreatCircleDistance.fromDegrees(latitude1: point1.latitude, longitude1: point1.longitude, latitude2: point2.latitude, longitude2: point2.longitude);
    if (method == 1)
      return gcd.haversineDistance();  //miles
    else if (method == 2)
      return gcd.sphericalLawOfCosinesDistance()/1000;  // meters / 1000 = kilometers
    else
      return gcd.vincentyDistance();
  }


  checkUserGps() async
  {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    if(permission == LocationPermission.whileInUse || permission == LocationPermission.always){
      await getLocationString().then((value){

        geoPosition = createGeoPoint(value);

      });
    }
  }

  removeFavorite(String truckid) async
  {
    User? user = await FirebaseAuth.instance.currentUser;
    DBService.instance.removeFavorite(truckid, user!.uid).then((value) {
      print('remove from favorite');
      truckList.value.clear();
      getData();
    });
  }

  getData() async{
    truckList.value.clear();
    truckmodelDistanceList.value.clear();
    truckModel.clear();
    await checkUserGps();
    double rangeAllowed = 500;
    isLoading.value = true;
    User? user = await FirebaseAuth.instance.currentUser;
    if(user!=null){
      await DBService.instance.getAllFavouruteTruck(user.uid).then((value) {
        truckList.clear();
        truckList.value = value;
        if(geoPosition!=null){
          if(truckList.value.length>0){
            truckmodelDistanceList.value.clear();
            truckList.forEach((element) {
              String _distance = getDistanceBetween(element.geoPosition, geoPosition).toStringAsFixed(1);
              distanceBetween.value = double.parse(_distance);
              if(distanceBetween.value<rangeAllowed){
                bool isfavorite = true;

                truckmodelDistanceList.add(new TruckModelDistance(
                    element.uid, element.id, element.name, element.phone, element.email,
                    element.address, element.description, element.image,
                    element.starttime, element.endtime, element.location,
                    element.geoPosition, double.parse(_distance),
                    element.fblink,element.instalink,element.imagelist,isfavorite));
              }
            });
            truckModel.sort((a,b)=>a.distance.compareTo(b.distance));
          }
        }
      });
      isLoading.value = false;
      isLogin.value = true;
    }else{
      isLoading.value = false;
      isLogin.value = false;
    }

  }

  @override
  void onInit() async{
    // TODO: implement onInit
    getData();
    super.onInit();
  }


}