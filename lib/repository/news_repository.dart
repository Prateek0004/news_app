import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/News_channels_headlines_models.dart';

import '../models/categories_news_model.dart';

class NewsRepo {
  Future<NewsChannelsHeadlinesModels> fetchNewsChannelsHeadlinesApi(String source) async {
    String url = "https://newsapi.org/v2/top-headlines?sources=$source&apiKey=488efea329084f819a86701580122195";

    final response = await http.get(Uri.parse(url));

    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModels.fromJson(body);
    }
    throw Exception('Error');
  }



  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String url = "https://newsapi.org/v2/everything?q=${category}&apiKey=488efea329084f819a86701580122195";

    final response = await http.get(Uri.parse(url));

    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }

}
