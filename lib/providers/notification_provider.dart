import 'package:ewaste/models/notification_model.dart';
import 'package:ewaste/models/transaksi_model.dart';
import 'package:ewaste/services/notification_service.dart';
import 'package:ewaste/services/transaksi_service.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notification = [];

  List<NotificationModel> get notification => _notification;

  set notification(List<NotificationModel> notification) {
    _notification = notification;
    notifyListeners();
  }

  // GET TRANSAKSI USER
  Future<void> getNotification() async {
    try {
      List<NotificationModel> notification =
          await NotificationService().getNotification();
      _notification = notification;
    } catch (e) {
      print(e);
    }
  }
}
