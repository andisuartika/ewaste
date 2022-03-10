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
  Future<bool> editProfile({
    user,
    filepath,
  }) async {
    // var stream = http.ByteStream(DelegatingStream.typed(filepath.openRead()));
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/user'));
    // var multipartFile = http.MultipartFile("image", stream, length, filename: path.basename(filepath.path));
    request.fields['email'] = user['email'];
    request.fields['name'] = user['name'];
    request.fields['noHp'] = user['noHp'];
    request.fields['alamat'] = user['alamat'];
    if (filepath != '') {
      request.files.add(
          await http.MultipartFile.fromPath('profile_photo_path', filepath));
    }
    request.headers.addAll({
      'Authorization': user['token'],
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    var response = await request.send();
    //final response = await http.post(Uri.parse('$_host/panen'), body:_panen);
    if (response.statusCode == 200) {
      //return ErrorMSG.fromJson(jsonDecode(response.body));
      final respStr = await response.stream.bytesToString();
      print(respStr);
      return true;
    } else {
      throw Exception('Gagal Update Profile');
    }
  }

  // CHANGE PASSWORD
  Future<bool> changePassword({
    required String email,
    required String password,
    required String newPassword,
    required String token,
  }) async {
    var url = '$baseUrl/changePassword';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'email': email,
      'password': password,
      'new_password': newPassword,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(password);

    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Ubah Kata sandi Profile');
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
