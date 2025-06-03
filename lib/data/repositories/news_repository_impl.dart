import 'dart:convert';

import 'package:getx_news_clean_arch/data/providers/news_api.dart';
import 'package:getx_news_clean_arch/domain/entities/news_article.dart';
import 'package:getx_news_clean_arch/domain/entities/news_response.dart';
import 'package:getx_news_clean_arch/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApi api;

  NewsRepositoryImpl(this.api);

  @override
  Future<List<NewsArticle>> getArticles(String category) async {
    final rawList = await api.fetchNews(category);
    var list = NewsResponse.fromJson(rawList);
    return list.articles??[];
  }
}