import 'package:ewaste/providers/article_provider.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/bank_provider.dart';
import 'package:ewaste/providers/page_provider.dart';
import 'package:ewaste/providers/sampah_provider.dart';
import 'package:ewaste/providers/slider_provider.dart';
import 'package:ewaste/screens/cari_nasabah_screen.dart';
import 'package:ewaste/screens/home/input_sampah_screen.dart';
import 'package:ewaste/screens/home/main_screen.dart';
import 'package:ewaste/screens/konfirmasi_iuran_sampah_screen.dart';
import 'package:ewaste/screens/konfirmasi_tabungan_screen.dart';
import 'package:ewaste/screens/profile/panduan_aplikasi_screen.dart';
import 'package:ewaste/screens/profile/pusat_bantuan_screen.dart';
import 'package:ewaste/screens/profile/syarat_ketentuan_screen.dart';
import 'package:ewaste/screens/profile/ubah_password_screen.dart';
import 'package:ewaste/screens/profile/ubah_profile_screen.dart';
import 'package:ewaste/screens/profile/versi_aplikasi_screen.dart';
import 'package:ewaste/screens/qr_screen.dart';
import 'package:ewaste/screens/sampah_campuran_screen.dart';
import 'package:ewaste/screens/sampah_terpilah_screen.dart';
import 'package:ewaste/screens/login_screen.dart';
import 'package:ewaste/screens/register_screen.dart';
import 'package:ewaste/screens/splash_screen.dart';
import 'package:ewaste/screens/tarik/tarik_bank_screen.dart';
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
        ChangeNotifierProvider(
          create: (context) => ArticleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SliderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SampahProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BankProvider(),
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
          '/ubah-profile': (context) => UbahProfileScreen(),
          '/ubah-password': (context) => UbahPasswordScreen(),
          '/versi-aplikasi': (context) => VersiAplikasiScreen(),
          '/panduan-aplikasi': (context) => PanduanAplikasiScren(),
          '/syarat-ketentuan': (context) => SyaratdanKetentuanScreen(),
          '/pusat-bantuan': (context) => PusatBantuanScreen(),
          '/qr-scan': (context) => QrScreen(),
          '/cari-nasabah': (context) => CariNasabahScreen(),
          '/tarik-bank': (context) => TarikBankScreen(),
        },
      ),
    );
  }
}
