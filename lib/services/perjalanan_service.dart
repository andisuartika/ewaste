import 'dart:convert';

import 'package:ewaste/models/perjalanan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PerjalananService {
  String baseUrl = 'https://wastebali.com/api';

  // GET PERJALANAN ONDATE
  Future<List<PerjalananModel>> getPerjalanan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/perjalanan/petugas';
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
      List<PerjalananModel> perjalanan = [];
      for (var item in data) {
        perjalanan.add(PerjalananModel.fromJson(item));
      }
      return perjalanan;
    } else {
      throw Exception('Gagal Mendapatkan Data Perjalanan');
    }
  }

  // GET ALL PERJALANAN
  Future<List<PerjalananModel>> getAllPerjalanan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/perjalanan';
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
      List<PerjalananModel> perjalanan = [];
      for (var item in data) {
        perjalanan.add(PerjalananModel.fromJson(item));
      }
      return perjalanan;
    } else {
      throw Exception('Gagal Mendapatkan Data Perjalanan');
    }
  }

  Future<bool> updatePerjalanan({
    required String status,
    required int id,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/perjalanan/petugas/$id';
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var body = jsonEncode({
      'status': status,
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
      throw Exception('Gagal Update Data Perjalanan');
    }
  }
}
