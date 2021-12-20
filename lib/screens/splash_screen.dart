import 'dart:async';

import 'package:ewaste/theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/welcome');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Center(
        child: Container(
          width: 160,
          height: 200,
          child: Column(
            children: [
              Container(
                width: 130,
                height: 124,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/ewaste.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '- Sampah jadi Rupiah -',
                style: darkGreenTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
