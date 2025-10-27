import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_news_clean_arch/domain/entities/news_article.dart';
import 'package:getx_news_clean_arch/domain/usecases/get_articles.dart';
import 'package:home_widget/home_widget.dart';

import '../routes/app_routes.dart';

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

    // Listen if user tapped the widget when app already running
    HomeWidget.widgetClicked.listen((uri) {
      if (uri != null) {
        // parse uri and route with Get.toNamed('/article', arguments: {...})
        final q = uri.queryParameters;
        if (q.containsKey('url')) {
          Get.toNamed(AppRoutes.detailsPage, arguments: {'url': q['url']});
        }
      }
    });

    // Handle the case where the app was launched from a widget
    HomeWidget.initiallyLaunchedFromHomeWidget().then((uri) {
      if (uri != null && uri.queryParameters.containsKey('url')) {
        Get.toNamed(AppRoutes.detailsPage, arguments: {'url': uri.queryParameters['url']});
      }
    });

    // Tab Controller with Animation
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

  void fetchArticles(String category, {int limit = 10}) async {
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

  Future<void> updateHomeWidgetTop5() async {
    final top5 = await getArticlesUseCase("business");
    final list = top5.map((a) => {'title': a.title, 'url': a.url}).toList();
    final jsonStr = jsonEncode(list);

    // Save to widget storage
    await HomeWidget.saveWidgetData<String>('news_json', jsonStr);

    // Trigger a widget update (use your exact provider/class name below)
    await HomeWidget.updateWidget(
      androidName: 'NewsWidgetProvider',
      qualifiedAndroidName: 'com.yourcompany.yourapp.NewsWidgetProvider',
    );
  }


  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}