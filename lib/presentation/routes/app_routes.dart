import 'package:get/get_navigation/src/routes/get_route.dart';

import '../bindings/home_binding.dart';
import '../pages/home_page.dart';

class AppRoutes {
  // static const String splashPage = '/';
  static const String homePage = '/home';


  static List<GetPage> pages = [
    GetPage(
        name: homePage,
        page: () => HomePage(),
        bindings: [HomeBinding()]),
  ];
}