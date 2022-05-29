import 'dart:convert';

import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  // UPDATE FCM TOKEN
  Future<bool> fcmToken({
    required String fcmToken,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/fcm-token';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'token': fcmToken,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      return true;
    } else {
      throw Exception('Error Update Token!');
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
    print(user);
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
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);
      user.token = token;

      return user;
    } else {
      UserPreferences().removeToken();
      throw Exception('Error Get User');
    }
  }

  Future<bool> logout({
    required String token,
    required String fcmToken,
  }) async {
    print(fcmToken);
    var url = '$baseUrl/logout';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'fcmToken': fcmToken,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      return true;
    } else {
      throw Exception('Error Logout');
    }
  }
}
