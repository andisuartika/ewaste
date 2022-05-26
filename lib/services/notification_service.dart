import 'dart:convert';

import 'package:ewaste/models/notification_model.dart';
import 'package:ewaste/models/transaksi_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  String baseUrl = 'https://wastebali.com/api';

  // GET TRANSAKSI USER
  Future<List<NotificationModel>> getNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/notification';
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
      List<NotificationModel> notification = [];
      for (var item in data) {
        notification.add(NotificationModel.fromJson(item));
      }

      return notification;
    } else {
      throw Exception('Gagal Mendapatkan Data Notification');
    }
  }
}
