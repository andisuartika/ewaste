import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/services/auth_service.dart';
import 'package:ewaste/utils/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  // GET USER
  Future<void> getUser(_token) async {
    try {
      UserModel user = await AuthService().getUser(token: _token);
      _user = user;
    } catch (e) {
      print(e);
    }
  }

  // REGISTER
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        email: email,
        password: password,
      );

      _user = user;
      UserPreferences().saveUser(_user);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // LOGIN
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;

      UserPreferences().saveUser(_user);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // UPDATE TOKEN
  Future<bool> fcmToken({
    required String fcmToken,
  }) async {
    try {
      bool res = await AuthService().fcmToken(fcmToken: fcmToken);
      return res;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // // EDIT PROFILE
  // Future<bool> editProfile({
  //   required String name,
  //   required String email,
  //   required String alamat,
  //   required String noHp,
  //   required String token,
  //   filepath,
  // }) async {
  //   try {
  //     UserModel user = await AuthService().editProfile(
  //       name: name,
  //       email: email,
  //       alamat: alamat,
  //       noHp: noHp,
  //       token: token,
  //       filepath: filepath,
  //     );

  //     _user = user;

  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  // CHANGE PASSWORD
  Future<bool> changePassword({
    required String email,
    required String password,
    required String newPassword,
    required String token,
  }) async {
    try {
      bool mess = await AuthService().changePassword(
        email: email,
        password: password,
        newPassword: newPassword,
        token: token,
      );
      print(mess);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // LOGOUT
  Future<bool> logout({
    required String token,
    required String fcmToken,
  }) async {
    try {
      // API LOGOUT
      bool res = await AuthService().logout(token: token, fcmToken: fcmToken);
      print('authprov :' + res.toString());
      // REMOVE TOKEN
      UserPreferences().removeToken();
      return res;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
