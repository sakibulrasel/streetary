import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streetary/core/widget/mytext.dart';
import 'package:streetary/data/img.dart';
import 'package:streetary/data/mycolor.dart';
import 'package:streetary/feature/splash/controller/splash_controller.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController = Get.find<SplashController>();
  @override
  void initState() {
    // TODO: implement initState
    splashController.navigateToHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // splashController.navigateToHomeScreen();
    return Scaffold(
        body: Stack(
          children: [
            Align(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 200, height: 100,
                      child:
                      Image.asset(Img.get('logo.jpg'), fit: BoxFit.cover),
                    ),
                    Container(height: 10),
                    Text("Streetary", style: MyText.headline(context)!.copyWith(
                        color: Colors.grey[800], fontWeight: FontWeight.w600
                    )),
                    Container(height: 10),
                    Text("Find your street food", style: MyText.body1(context)!.copyWith(
                        color: Colors.grey[800], fontWeight: FontWeight.w600
                    )),
                    Container(height: 20),
                    Container( height: 5, width: 80,
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(MyColors.primaryLight),
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
              alignment: Alignment.center,
            )
          ],
        ),
    );
  }
}

