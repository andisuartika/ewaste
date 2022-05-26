import 'dart:async';

import 'package:ewaste/providers/article_provider.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/notification_provider.dart';
import 'package:ewaste/providers/sampah_provider.dart';
import 'package:ewaste/providers/slider_provider.dart';
import 'package:ewaste/providers/transaksi_provider.dart';
import 'package:ewaste/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    cekLogin();
    super.initState();
    Provider.of<ArticleProvider>(context, listen: false).getArticles();

    Provider.of<SampahProvider>(context, listen: false).getSampah();
    Provider.of<SliderProvider>(context, listen: false).getSliders();
    Provider.of<TransaksiProvider>(context, listen: false).getTransaksi();
    Provider.of<NotificationProvider>(context, listen: false).getNotification();
  }

  cekLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool islogin = prefs.getBool('isLogin') ?? false;
    String? token = prefs.getString('token');

    // Get user Data
    if (islogin == true) {
      print('login true');
      await Provider.of<AuthProvider>(context, listen: false).getUser(token);
    }
    print('ISLOGIN : $islogin TOKEN : $token');
    islogin
        ? Navigator.pushNamed(context, '/main')
        : Navigator.pushNamed(context, '/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Center(
        child: Container(
          width: 160,
          height: 200,
          child: Image.asset('assets/splash_logo.png'),
        ),
      ),
    );
  }
}
