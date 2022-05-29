import 'package:ewaste/models/perjalanan_model.dart';
import 'package:ewaste/services/perjalanan_service.dart';
import 'package:flutter/cupertino.dart';

class AllPerjalananProvider with ChangeNotifier {
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
          await PerjalananService().getAllPerjalanan();
      _perjalanan = perjalanan;
      print(_perjalanan);
    } catch (e) {
      print(e);
    }
  }
}
