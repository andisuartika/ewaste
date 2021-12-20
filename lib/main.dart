import 'package:ewaste/screens/login_screen.dart';
import 'package:ewaste/screens/register_screen.dart';
import 'package:ewaste/screens/splash_screen.dart';
import 'package:ewaste/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
