import 'package:ewaste/providers/all_perjalanan_provider.dart';
import 'package:ewaste/providers/article_provider.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/bank_provider.dart';
import 'package:ewaste/providers/notification_provider.dart';
import 'package:ewaste/providers/page_provider.dart';
import 'package:ewaste/providers/perjalanan_provider.dart';
import 'package:ewaste/providers/sampah_provider.dart';
import 'package:ewaste/providers/slider_provider.dart';
import 'package:ewaste/providers/tabungan_provider.dart';
import 'package:ewaste/providers/transaksi_provider.dart';
import 'package:ewaste/screens/cari_nasabah_screen.dart';
import 'package:ewaste/screens/home/main_screen.dart';
import 'package:ewaste/screens/profile/panduan_aplikasi_screen.dart';
import 'package:ewaste/screens/profile/pusat_bantuan_screen.dart';
import 'package:ewaste/screens/profile/syarat_ketentuan_screen.dart';
import 'package:ewaste/screens/profile/ubah_password_screen.dart';
import 'package:ewaste/screens/profile/ubah_profile_screen.dart';
import 'package:ewaste/screens/profile/versi_aplikasi_screen.dart';
import 'package:ewaste/screens/qr_screen.dart';
import 'package:ewaste/screens/login_screen.dart';
import 'package:ewaste/screens/register_screen.dart';
import 'package:ewaste/screens/splash_screen.dart';
import 'package:ewaste/screens/tarik/tarik_bank_screen.dart';
import 'package:ewaste/screens/wallet_screen.dart';
import 'package:ewaste/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        ChangeNotifierProvider(
          create: (context) => TransaksiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TabunganProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PerjalananProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllPerjalananProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashScreen(),
          '/welcome': (context) => WelcomeScreen(),
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
          '/main': (context) => MainScreen(),
          '/ubah-profile': (context) => UbahProfileScreen(),
          '/ubah-password': (context) => UbahPasswordScreen(),
          '/versi-aplikasi': (context) => VersiAplikasiScreen(),
          '/panduan-aplikasi': (context) => PanduanAplikasiScren(),
          '/syarat-ketentuan': (context) => SyaratdanKetentuanScreen(),
          '/pusat-bantuan': (context) => PusatBantuanScreen(),
          '/qr-scan': (context) => QrScreen(),
          '/cari-nasabah': (context) => CariNasabahScreen(),
          '/tarik-bank': (context) => TarikBankScreen(),
          '/tabungan-nasabah': (context) => WalletScreen(),
          '/transaksi': (context) => MainScreen(pageIndex: 1),
          '/notification': (context) => MainScreen(pageIndex: 3),
        },
      ),
    );
  }
}
