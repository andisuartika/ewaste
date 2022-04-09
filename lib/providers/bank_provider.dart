import 'package:ewaste/faker/bank_faker.dart';
import 'package:ewaste/models/bank_model.dart';
import 'package:flutter/cupertino.dart';

class BankProvider with ChangeNotifier {
  List<BankModel> _banks = [];

  List<BankModel> get banks => _banks;

  set banks(List<BankModel> banks) {
    _banks = banks;
    notifyListeners();
  }

  Future<void> getBanks() async {
    try {
      List<BankModel> banks = banksFaker;

      _banks = banks;
    } catch (e) {
      print(e);
    }
  }
}
