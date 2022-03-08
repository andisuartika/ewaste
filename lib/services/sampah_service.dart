import 'dart:convert';

import 'package:ewaste/models/sampah_model.dart';

import 'package:http/http.dart' as http;

class SampahService {
  String baseUrl = 'https://wastebali.com/api';

  // GET USER
  Future<List<SampahModel>> getSampah() async {
    var url = '$baseUrl/sampah';
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      // print(data);

      List<SampahModel> sampah = [];
      for (var item in data) {
        sampah.add(SampahModel.fromJson(item));
      }

      return sampah;
    } else {
      throw Exception('Error Get Sampah');
    }
  }
}
