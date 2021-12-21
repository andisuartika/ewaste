import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/page_provider.dart';
import 'package:ewaste/screens/home/input_sampah_screen.dart';
import 'package:ewaste/screens/home/main_screen.dart';
import 'package:ewaste/screens/konfirmasi_iuran_sampah_screen.dart';
import 'package:ewaste/screens/konfirmasi_tabungan_screen.dart';
import 'package:ewaste/screens/sampah_campuran_screen.dart';
import 'package:ewaste/screens/sampah_terpilah_screen.dart';
import 'package:ewaste/screens/login_screen.dart';
import 'package:ewaste/screens/register_screen.dart';
import 'package:ewaste/screens/splash_screen.dart';
import 'package:ewaste/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashScreen(),
          '/welcome': (context) => WelcomeScreen(),
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
          '/main': (context) => MainScrenn(),
          '/sampah': (context) => InputSampahScreen(),
          '/sampah-terpilah': (context) => SampahTerpilahScreen(),
          '/sampah-campuran': (context) => SampahCampuranScreen(),
          '/konfirmasi-tabungan': (context) => KonfirmasiTabunganScreen(),
          '/konfirmasi-sampah': (context) => KonfirmasiIuranSampahScreen(),
        },
      ),
    );
  }
}
