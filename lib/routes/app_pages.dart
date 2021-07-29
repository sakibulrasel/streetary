import 'package:get/get.dart';
import 'package:streetary/feature/dashboard/binding/dashboard_binding.dart';
import 'package:streetary/feature/dashboard/view/dashboard_view.dart';
import 'package:streetary/feature/edit_truck/binding/edit_truck_binding.dart';
import 'package:streetary/feature/edit_truck/view/edit_truck_view.dart';
import 'package:streetary/feature/home/binding/home_binding.dart';
import 'package:streetary/feature/home/view/home_screen.dart';
import 'package:streetary/feature/login/binding/login_binding.dart';
import 'package:streetary/feature/login/view/login_screen.dart';
import 'package:streetary/feature/new_menu/binding/new_menu_binding.dart';
import 'package:streetary/feature/new_menu/view/new_menu_screen.dart';
import 'package:streetary/feature/new_truck/binding/new_truck_binding.dart';
import 'package:streetary/feature/new_truck/view/new_truck_view.dart';
import 'package:streetary/feature/register/binding/register_binding.dart';
import 'package:streetary/feature/register/view/register_screen.dart';
import 'package:streetary/feature/splash/binding/splash_binding.dart';
import 'package:streetary/feature/splash/view/splash_screen.dart';
import 'package:streetary/feature/streateries_view/binding/streateries_view_binding.dart';
import 'package:streetary/feature/streateries_view/view/streateries_view_screen.dart';
import 'package:streetary/feature/user_profile/binding/user_profile_binding.dart';
import 'package:streetary/feature/user_profile/controller/user_profile_controller.dart';
import 'package:streetary/feature/user_profile/view/user_profile_screen.dart';
import 'package:streetary/feature/view_menu/binding/view_menu_binding.dart';
import 'package:streetary/feature/view_menu/view/view_menu_screen.dart';
import 'package:streetary/feature/view_truck/binding/view_truck_binding.dart';
import 'package:streetary/feature/view_truck/view/view_truck_screen.dart';

import 'app_routes.dart';

/**
 * Created by sakibul.haque on 01,July,2021
 */

class AppPages {
  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
       name: Routes.LOGIN,
       page: ()=>LoginScreen(),
       binding: LoginBinding()
    ),
    GetPage(
        name: Routes.REGISTER,
        page: ()=>RegisterScreen(),
        binding: RegisterBinding()
    ),
    GetPage(
        name: Routes.HOME,
        page: ()=>HomeScreen(),
        binding: HomeBinding()
    ),
    GetPage(
        name: Routes.DASHBOARD,
        page: ()=>DashboardScreen(),
        binding: DashboardBinding()
    ),
    GetPage(
        name: Routes.NEW_TRUCK,
        page: ()=>NewTrcukScreen(),
        binding: NewTruckBinding()
    ),
    GetPage(
        name: Routes.VIEW_TRUCK,
        page: ()=>ViewTruckScreen(),
        binding: ViewTruckBinding()
    ),

    GetPage(
        name: Routes.NEW_MENU,
        page: ()=>NewMenuScreen(),
        binding: NewMenuBindings()
    ),
    GetPage(
        name: Routes.VIEW_MENU,
        page: ()=>ViewMenuScreen(),
        binding: ViewMenuBinding()
    ),
    GetPage(
        name: Routes.USER_PROFILE,
        page: ()=>UserProfileScreen(),
        binding: UserProfileBinding()
    ),


  ];
}