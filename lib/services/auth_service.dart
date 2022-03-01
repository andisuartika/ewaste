import 'dart:convert';

import 'package:ewaste/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'https://wastebali.com/api';

  // REGISTER
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  // LOGIN
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  // EDIT PROFILE
  Future<UserModel> editProfile({
    required String email,
    required String name,
    required String noHp,
    required String alamat,
    required String token,
  }) async {
    var url = '$baseUrl/user';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'email': email,
      'name': name,
      'noHp': noHp,
      'alamat': alamat,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);
      user.token = token;
      return user;
    } else {
      throw Exception('Gagal Update Profile');
    }
  }

  // GET USER
  Future<UserModel> getUser({
    required String token,
  }) async {
    var url = '$baseUrl/user';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);
      user.token = token;

      return user;
    } else {
      throw Exception('Error Get User');
    }
  }

  Future<bool> logout({
    required String token,
  }) async {
    var url = '$baseUrl/logout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      return true;
    } else {
      throw Exception('Error Logout');
    }
  }
}
