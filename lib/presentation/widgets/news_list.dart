import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../core/utils/date_utility.dart';
import '../controllers/home_controller.dart';

class NewsList extends GetView<HomeController> {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        itemCount: controller.articles.length,
        itemBuilder: (context, index) {
          final article = controller.articles[index];

          return Card(
            color: Colors.red.shade50,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        article.urlToImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title!,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                maxLines: 3,
                              ),
                              Text(
                                'Published: ${DateUtility.formatToHumanReadable(article.publishedAt!)}',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              Text(
                                'Source: ${article.source!.name!}',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(article.description!,
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                          fontSize: 12))
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
