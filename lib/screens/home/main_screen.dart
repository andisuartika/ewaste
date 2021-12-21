import 'package:ewaste/providers/page_provider.dart';
import 'package:ewaste/screens/home/home_screen.dart';
import 'package:ewaste/screens/home/pesan_screen.dart';
import 'package:ewaste/screens/home/profile_screen.dart';
import 'package:ewaste/screens/home/riwayat_screen.dart';
import 'package:ewaste/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScrenn extends StatefulWidget {
  const MainScrenn({Key? key}) : super(key: key);

  @override
  _MainScrennState createState() => _MainScrennState();
}

class _MainScrennState extends State<MainScrenn> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // PAGE PROVIDER
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    // FLOATING BUTTON SAMPAH
    Widget sampahButton() {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/sampah');
        },
        backgroundColor: primaryDarkColor,
        child: Image.asset(
          'assets/icon_sampah.png',
          width: 25,
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
          child: BottomNavigationBar(
            backgroundColor: whiteColor,
            currentIndex: pageProvider.currentIndex,
            onTap: (value) {
              print(value);
              pageProvider.currentIndex = value;
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon_home.png',
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
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon_riwayat.png',
                    width: 20,
                    color: pageProvider.currentIndex == 1
                        ? primaryColor
                        : Color(0xFF728196),
                  ),
                ),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon_pesan.png',
                    width: 22,
                    color: pageProvider.currentIndex == 2
                        ? primaryColor
                        : Color(0xFF728196),
                  ),
                ),
                label: 'Pesan',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon_profile.png',
                    width: 18,
                    color: pageProvider.currentIndex == 3
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
          return PesanScreen();
          break;
        case 3:
          return ProfileScreen();
          break;

        default:
          return HomeScreen();
      }
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      floatingActionButton: sampahButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
