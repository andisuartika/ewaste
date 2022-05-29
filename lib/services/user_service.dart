import 'dart:convert';

import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  String baseUrl = 'https://wastebali.com/api';

  // GET USERS
  Future<List<UserModel>> getUsers({required String search}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/getUser?name=$search';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body)['data'];
      var data = res['data'];
      List<UserModel> user = [];
      for (var item in data) {
        user.add(UserModel.fromJson(item));
      }

      return user;
    } else {
      throw Exception('Gagal Mendapatkan Data Users');
    }
  }
}
