import 'package:ewaste/models/transaksi_model.dart';
import 'package:ewaste/services/transaksi_service.dart';
import 'package:flutter/material.dart';

class TransaksiProvider with ChangeNotifier {
  List<TransaksiModel> _transaksi = [];

  List<TransaksiModel> get transaksi => _transaksi;

  set transaksi(List<TransaksiModel> transaksi) {
    _transaksi = transaksi;
    notifyListeners();
  }

  // GET TRANSAKSI USER
  Future<void> getTransaksi() async {
    try {
      List<TransaksiModel> transaksi = await TransaksiService().getTransaksi();
      _transaksi = transaksi;
    } catch (e) {
      print(e);
    }
  }

  // POST TRANSAKSI POIN
  Future<bool> transaksiPoin({
    required int bank,
    required String nomor,
    required String nama,
    required int jumlah,
    required String password,
  }) async {
    try {
      bool res = await TransaksiService().transaksiPoin(
        bank: bank,
        nomor: nomor,
        nama: nama,
        jumlah: jumlah,
        password: password,
      );

      return res;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // PEMBAYARAN IURAN
  Future<bool> pembayaranIuran({
    required int total,
    required String password,
  }) async {
    try {
      bool res = await TransaksiService()
          .pembayaranIuran(total: total, password: password);

      return res;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
