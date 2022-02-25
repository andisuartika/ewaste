import 'package:ewaste/faker/article_faker.dart';
import 'package:ewaste/models/article_model.dart';
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
      List<ArticleModel> articles = articlesFaker;
      _articles = articles;
    } catch (e) {
      print(e);
    }
  }
}
