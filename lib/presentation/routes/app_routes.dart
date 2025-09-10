import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:getx_news_clean_arch/presentation/pages/news_details_page.dart';

import '../bindings/home_binding.dart';
import '../pages/home_page.dart';

class AppRoutes {
  // static const String splashPage = '/';
  static const String homePage = '/home';
  static const String detailsPage = '/details';


  static List<GetPage> pages = [
    GetPage(
        name: homePage,
        page: () => HomePage(),
        bindings: [HomeBinding()]),

    GetPage(
        name: detailsPage,
        page: () => NewsDetailsPage(),
        bindings: [HomeBinding()]),
  ];
}