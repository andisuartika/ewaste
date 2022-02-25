import 'package:ewaste/faker/slider_faker.dart';
import 'package:ewaste/models/slider_model.dart';
import 'package:flutter/material.dart';

class SliderProvider with ChangeNotifier {
  List<SliderModel> _sliders = [];

  List<SliderModel> get sliders => _sliders;

  set sliders(List<SliderModel> sliders) {
    _sliders = sliders;
    notifyListeners();
  }

  Future<void> getSliders() async {
    try {
      List<SliderModel> sliders = slidersFaker;
      _sliders = sliders;
    } catch (e) {
      print(e);
    }
  }
}
