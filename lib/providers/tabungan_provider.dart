import 'package:ewaste/models/tabungan_model.dart';
import 'package:ewaste/services/transaksi_service.dart';
import 'package:flutter/cupertino.dart';

class TabunganProvider with ChangeNotifier {
  late TabunganModel _tabungan;

  TabunganModel get tabungan => _tabungan;

  set tabungan(TabunganModel tabungan) {
    _tabungan = tabungan;
    notifyListeners();
  }

  // GET USER
  Future<void> getTabungan() async {
    try {
      TabunganModel tabungan = await TransaksiService().getTabungan();
      _tabungan = tabungan;
    } catch (e) {
      print(e);
    }
  }
}
