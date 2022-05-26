import 'dart:convert';

import 'package:ewaste/models/transaksi_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransaksiService {
  String baseUrl = 'https://wastebali.com/api';

  // GET TRANSAKSI USER
  Future<List<TransaksiModel>> getTransaksi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/transaksi';
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
      List<TransaksiModel> transaksi = [];
      for (var item in data) {
        transaksi.add(TransaksiModel.fromJson(item));
      }

      return transaksi;
    } else {
      throw Exception('Gagal Mendapatkan Data Transaksi');
    }
  }

  // TRANSAKSI TARIK POINT
  Future<bool> transaksiPoin({
    required int bank,
    required String nomor,
    required String nama,
    required int jumlah,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/transaksi/poin';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'bank': bank,
      'nama': nama,
      'nomor': nomor,
      'jumlah': jumlah,
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
      return true;
    } else {
      throw Exception('Transaksi Gagal');
    }
  }

  // PEMBAYARAN IURAN
  Future<bool> pembayaranIuran({
    required int total,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/transaksi/pembayaran';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'total': total,
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
      return true;
    } else {
      throw Exception('Transaksi Gagal');
    }
  }
}
