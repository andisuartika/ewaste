import 'package:ewaste/models/sampah_model.dart';
import 'package:ewaste/services/sampah_service.dart';
import 'package:flutter/cupertino.dart';

class SampahProvider with ChangeNotifier {
  List<SampahModel> _sampah = [];

  List<SampahModel> get sampah => _sampah;

  set sampah(List<SampahModel> sampah) {
    _sampah = sampah;
    notifyListeners();
  }

  // GET SAMPAH
  Future<void> getSampah() async {
    try {
      List<SampahModel> sampah = await SampahService().getSampah();
      _sampah = sampah;
      print('Provider: $_sampah');
    } catch (e) {
      print(e);
    }
  }
}
