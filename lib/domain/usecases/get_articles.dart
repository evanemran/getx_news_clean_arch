import 'package:getx_news_clean_arch/domain/entities/news_article.dart';
import 'package:getx_news_clean_arch/domain/repositories/news_repository.dart';

class GetArticles {
  final NewsRepository repository;

  GetArticles(this.repository);

  Future<List<NewsArticle>> call() => repository.getArticles();
}