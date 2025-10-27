import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:getx_news_clean_arch/presentation/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    title: 'GetX eCommerce App',
    initialRoute: AppRoutes.homePage,
    getPages: AppRoutes.pages,
    debugShowCheckedModeBanner: false,
  ));
}



