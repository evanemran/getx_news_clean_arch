import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_news_clean_arch/domain/entities/news_article.dart';
import 'package:getx_news_clean_arch/domain/usecases/get_articles.dart';

class HomeController extends GetxController {
  final GetArticles getArticlesUseCase;
  var articles = <NewsArticle>[].obs;
  var isLoading = false.obs;

  final List<String> categories = [
    'Top News',
    'Business',
    'Technology',
    'Sports',
    'Entertainment',
    'Health',
    'Science',
    'World',
  ];

  HomeController(this.getArticlesUseCase);

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  void fetchArticles() async {
    isLoading.value = true;
    try {
      final result = await getArticlesUseCase();
      articles.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}