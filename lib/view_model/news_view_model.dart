import 'package:news_app/models/News_channels_headlines_models.dart';
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepo();

  Future<NewsChannelsHeadlinesModels> fetchNewsChannelsHeadlinesApi(String source) async {
    final response = await _repo.fetchNewsChannelsHeadlinesApi(source);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _repo.fetchCategoriesNewsApi(category);
    return response;
  }


}
