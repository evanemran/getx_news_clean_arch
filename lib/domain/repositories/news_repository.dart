import 'package:getx_news_clean_arch/domain/entities/news_article.dart';

abstract class NewsRepository {
  Future<List<NewsArticle>> getArticles(String category);
}