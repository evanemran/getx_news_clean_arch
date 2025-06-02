import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:getx_news_clean_arch/data/providers/news_api.dart';
import 'package:getx_news_clean_arch/data/repositories/news_repository_impl.dart';
import 'package:getx_news_clean_arch/domain/usecases/get_articles.dart';
import 'package:getx_news_clean_arch/presentation/controllers/home_controller.dart';

import '../../domain/repositories/news_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsApi());
    Get.lazyPut<NewsRepository>(() => NewsRepositoryImpl(Get.find()));
    Get.lazyPut(() => NewsRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetArticles(Get.find()));
    Get.lazyPut(() => HomeController(Get.find()));
  }
}