import 'dart:convert';

import 'package:ewaste/models/article_model.dart';
import 'package:ewaste/models/slider_model.dart';
import 'package:http/http.dart' as http;

class ContentService {
  String baseUrl = 'https://wastebali.com/api';

  // GET SLIDER
  Future<List<SliderModel>> getSlider() async {
    var url = '$baseUrl/banner';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      List<SliderModel> slider = [];
      for (var item in data) {
        slider.add(SliderModel.fromJson(item));
      }

      return slider;
    } else {
      throw Exception('Gagal Mendapatkan Slider');
    }
  }

  // GET ARTICLE
  Future<List<ArticleModel>> getArticle() async {
    var url = '$baseUrl/artikel';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      List<ArticleModel> article = [];
      for (var item in data) {
        article.add(ArticleModel.fromJson(item));
      }

      return article;
    } else {
      throw Exception('Gagal Mendapatkan Artikel');
    }
  }
}
