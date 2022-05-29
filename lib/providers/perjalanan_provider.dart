import 'package:ewaste/models/perjalanan_model.dart';
import 'package:ewaste/services/perjalanan_service.dart';
import 'package:flutter/cupertino.dart';

class PerjalananProvider with ChangeNotifier {
  List<PerjalananModel> _perjalanan = [];

  List<PerjalananModel> get perjalanan => _perjalanan;

  set perjalanan(List<PerjalananModel> perjalanan) {
    _perjalanan = perjalanan;
    notifyListeners();
  }

  // GET perjalanan
  Future<void> getperjalanan() async {
    try {
      List<PerjalananModel> perjalanan =
          await PerjalananService().getPerjalanan();
      _perjalanan = perjalanan;
      print(_perjalanan);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> updatePerjalanan({
    required String status,
    required int id,
  }) async {
    try {
      bool res =
          await PerjalananService().updatePerjalanan(id: id, status: status);

      return res;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
