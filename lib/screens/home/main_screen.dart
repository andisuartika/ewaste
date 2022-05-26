import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/page_provider.dart';
import 'package:ewaste/screens/home/home_screen.dart';
import 'package:ewaste/screens/home/input_sampah_screen.dart';
import 'package:ewaste/screens/home/pesan_screen.dart';
import 'package:ewaste/screens/home/profile_screen.dart';
import 'package:ewaste/screens/home/riwayat_screen.dart';
import 'package:ewaste/screens/wallet_screen.dart';
import 'package:ewaste/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class MainScreen extends StatefulWidget {
  final int pageIndex;
  const MainScreen({Key? key, this.pageIndex = 0}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  bool isPetugas = true;

  @override
  void initState() {
    // TODO: implement initState
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    // KETIKA NOTIFIKASI DI KLIK DAN KEADAAN ON TERMINATE
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        var _routeName = message.data['route'];
        Navigator.of(context).pushNamed(_routeName);
        print('Notification Clicked!!');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message != null) {
        var _routeName = message.data['route'];
        Navigator.of(context).pushNamed(_routeName);
        print('Notification Clicked!!');
      }
      // Navigation to
    });

    subscribe();
    super.initState();
  }

  // FCM SUBSCRIBE
  void subscribe() async {
    await FirebaseMessaging.instance.subscribeToTopic('allDevice');
  }

  @override
  Widget build(BuildContext context) {
    // PAGE PROVIDER
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    setState(() {
      currentIndex = widget.pageIndex;
      if (user.roles != 'PETUGAS') {
        isPetugas = false;
      } else if (user.roles != 'ADMIN') {
        isPetugas = false;
      }
    });

    // SHOW BOTTOM SHEET
    void showBottomSheet() => showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          context: context,
          builder: (context) => Container(
            height: 170,
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cari nasabah dengan',
                  style: darkGreenTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/qr-scan');
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icon_qr_code.svg',
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Scan dengan QR code',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: secondaryTextColor,
                  thickness: 1,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/cari-nasabah');
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icon_search_nasabah.svg',
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Cari nama nasabah',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );

    // FLOATING BUTTON SAMPAH
    Widget addButton() {
      return FloatingActionButton(
        onPressed: isPetugas
            ? showBottomSheet
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WalletScreen(),
                  ),
                );
              },
        backgroundColor: primaryDarkColor,
        child: isPetugas
            ? SvgPicture.asset(
                'assets/icon_add.svg',
                width: 40,
              )
            : SvgPicture.asset(
                'assets/icon_wallet.svg',
                width: 26,
              ),
      );
    }

    // CUSTOM BUTTON NAVBAR
    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: whiteColor,
              currentIndex: pageProvider.currentIndex,
              onTap: (value) {
                if (value != 2) {
                  setState(() {
                    pageProvider.currentIndex = value;
                  });
                }
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: SvgPicture.asset(
                      'assets/icon_home.svg',
                      width: 21,
                      color: pageProvider.currentIndex == 0
                          ? primaryColor
                          : Color(0xFF728196),
                    ),
                  ),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: SvgPicture.asset(
                      'assets/icon_riwayat.svg',
                      width: 20,
                      color: pageProvider.currentIndex == 1
                          ? primaryColor
                          : Color(0xFF728196),
                    ),
                  ),
                  label: 'Riwayat',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: SvgPicture.asset(
                      'assets/icon_pesan.svg',
                      width: 22,
                      color: pageProvider.currentIndex == 3
                          ? primaryColor
                          : Color(0xFF728196),
                    ),
                  ),
                  label: 'Pesan',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: SvgPicture.asset(
                      'assets/icon_profile.svg',
                      width: 18,
                      color: pageProvider.currentIndex == 4
                          ? primaryColor
                          : Color(0xFF728196),
                    ),
                  ),
                  label: 'Profile',
                ),
              ],
              selectedItemColor: primaryColor,
              selectedLabelStyle: greenTextStyle.copyWith(fontSize: 13),
              unselectedLabelStyle: secondaryTextStyle.copyWith(fontSize: 12),
            ),
          ),
        ),
      );
    }

    // SCREEN
    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return HomeScreen();
          break;
        case 1:
          return RiwayatScreen();
          break;
        case 2:
          return HomeScreen();
          break;
        case 3:
          return PesanScreen();
          break;
        case 4:
          return ProfileScreen();
          break;

        default:
          return HomeScreen();
      }
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      floatingActionButton: addButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
