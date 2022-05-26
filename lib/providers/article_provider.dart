import 'package:ewaste/faker/article_faker.dart';
import 'package:ewaste/models/article_model.dart';
import 'package:ewaste/services/content_service.dart';
import 'package:flutter/material.dart';

class ArticleProvider with ChangeNotifier {
  List<ArticleModel> _articles = [];

  List<ArticleModel> get articles => _articles;

  set articles(List<ArticleModel> articles) {
    _articles = articles;
    notifyListeners();
  }

  Future<void> getArticles() async {
    try {
      List<ArticleModel> articles = await ContentService().getArticle();
      _articles = articles;
    } catch (e) {
      print(e);
    }
  }
}
