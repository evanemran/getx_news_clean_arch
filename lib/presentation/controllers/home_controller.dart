import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_news_clean_arch/domain/entities/news_article.dart';
import 'package:getx_news_clean_arch/domain/usecases/get_articles.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin{
  final GetArticles getArticlesUseCase;
  var articles = <NewsArticle>[].obs;
  var isLoading = false.obs;
  late TabController tabController;
  int previousIndex = 0;

  final List<String> categories = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Technology',
    'Sports',
  ];

  HomeController(this.getArticlesUseCase);

  @override
  void onInit() {
    fetchArticles("sports");
    super.onInit();
    tabController = TabController(length: categories.length, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        print("Tab changed to ${tabController.index}");
        fetchArticles(categories[tabController.index].toLowerCase());
      }
    });
    tabController.animation?.addListener(() {
      final animationValue = tabController.animation!.value;
      final newIndex = tabController.index;

      // Only respond when animation completes and tab index is fully changed
      if (animationValue.round() == newIndex && previousIndex != newIndex) {
        previousIndex = newIndex;
        print("Tab changed to $newIndex");
        fetchArticles(categories[newIndex].toLowerCase());
      }
    });
  }

  void fetchArticles(String category) async {
    isLoading.value = true;
    try {
      final result = await getArticlesUseCase(category);
      articles.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}