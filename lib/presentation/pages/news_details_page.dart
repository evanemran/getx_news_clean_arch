import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/news_details_controller.dart';

class NewsDetailsPage extends GetView<NewsDetailsController> {
  const NewsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(controller.article.url!, style: const TextStyle(color: Colors.white),),
        bottom: controller.loadingProgress.value < 100
            ? PreferredSize(
          preferredSize: const Size(double.infinity, 4.0),
          child: Obx(()=> LinearProgressIndicator(
            value: controller.loadingProgress.value / 100.0,  // Show progress as a fraction
            backgroundColor: Colors.white,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
          )),
        )
            : null,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
      ),

      body: WebViewWidget(controller: controller.webViewController),
    );
  }
}
