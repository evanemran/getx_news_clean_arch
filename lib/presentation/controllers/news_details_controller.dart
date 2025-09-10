import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../domain/entities/news_article.dart';

class NewsDetailsController extends GetxController {
  final NewsArticle article = Get.arguments;

  late WebViewController webViewController;
  var loadingProgress = 0.obs;


  @override
  void onInit() {

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            loadingProgress.value = progress;
          },
          onPageStarted: (String url) {
            // You can add any logic here when a page starts loading
          },
          onPageFinished: (String url) {
            // You can add any logic here when a page finishes loading
          },
          onWebResourceError: (WebResourceError error) {
            // Handle errors if necessary
          },
        ),
      )
      ..loadRequest(Uri.parse(article.url!));
  }

}