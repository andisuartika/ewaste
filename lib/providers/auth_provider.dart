import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/services/auth_service.dart';
import 'package:ewaste/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<void> getUser(_token) async {
    try {
      UserModel user = await AuthService().getUser(token: _token);
      _user = user;
      print(user.name);
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

  // LOGOUT
  Future<bool> logout(_token) async {
    try {
      // API LOGOUT
      bool res = await AuthService().logout(token: _token);
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
