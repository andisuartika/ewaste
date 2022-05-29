import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:ewaste/widgets/profile_item.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    bool isLoading = false;

    _launch(url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceWebView: false,
        );
      } else {
        print("Not supported");
      }
    }

    // LOGOUT HANDLE
    handleLogout() async {
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      setState(() {
        isLoading = true;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        },
      );

      if (await authProvider.logout(token: user.token!, fcmToken: fcmToken!)) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redTextColor,
            content: Text(
              'Gagal Logout!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    // DIALOG
    Future<void> showLogoutDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icon_alert.svg',
                    color: redTextColor,
                    width: 80,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Keluar?',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'apa kamu yakin untuk keluar?',
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 44,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Tidak',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 44,
                        child: TextButton(
                          onPressed: handleLogout,
                          style: TextButton.styleFrom(
                            backgroundColor: redTextColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Yakin',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // HEADER
    Widget header() {
      return AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Akun Saya',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    // PROFILE
    Widget profile() {
      return Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(14),
            bottomRight: Radius.circular(14),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.03),
              spreadRadius: 5,
              blurRadius: 0,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 75,
              height: 75,
              margin: EdgeInsets.only(top: 20),
              child: ClipOval(
                child: user.profilePhotoPath == null
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: whiteColor,
                            width: 2,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              'http://wastebali.com/storage/usersProfile/user.png',
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: user.profilePhotoUrl.toString(),
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              user.name.toString(),
              style: whiteTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              user.email.toString(),
              style: whiteTextStyle.copyWith(
                fontSize: 12,
                fontWeight: light,
              ),
            ),
          ],
        ),
      );
    }

    // PENGATURAN AKUN
    Widget akun() {
      return Container(
        margin: EdgeInsets.only(top: 24),
        height: 200,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'Pengaturan Akun',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            user.roles == "USER"
                ? ProfileItem(
                    icon: 'assets/icon_gabung_nasabah.svg',
                    title: 'Gabung Menjadi Nasabah E-Waste',
                    press: () {
                      var url =
                          'https://api.whatsapp.com/send?phone=6283159409115&text=Hi%2C%20Admin%20E-Waste%20%20%F0%9F%98%83%20!%20Saya%20ingin%20bergabung%20menjadi%20Nasabah%20E-Waste.%0ANama%20%3A%20${user.name.toString()}%0AEmail%20%3A%20${user.email.toString()}%0ATerima%20kasih%20%F0%9F%8D%83';

                      _launch(url);
                    },
                  )
                : ProfileItem(
                    icon: 'assets/icon_gabung_nasabah.svg',
                    title: 'Kamu Sebagai ${user.roles} E-Waste',
                    press: () {},
                  ),
            Divider(
              thickness: 1,
              color: secondaryTextColor.withOpacity(0.5),
            ),
            ProfileItem(
              icon: 'assets/icon_edit_profile.svg',
              title: 'Ubah Profile',
              press: () {
                Navigator.pushNamed(context, '/ubah-profile');
              },
            ),
            Divider(
              thickness: 1,
              color: secondaryTextColor.withOpacity(0.5),
            ),
            ProfileItem(
              icon: 'assets/icon_edit_password.svg',
              title: 'Ganti Kata sandi',
              press: () {
                Navigator.pushNamed(context, '/ubah-password');
              },
            ),
          ],
        ),
      );
    }

    // TENTANG
    Widget tentang() {
      return Container(
        height: 260,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'Tentang',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ProfileItem(
              icon: 'assets/icon_playstore.svg',
              title: 'Versi Aplikasi',
              press: () {
                Navigator.pushNamed(context, '/versi-aplikasi');
              },
            ),
            Divider(
              thickness: 1,
              color: secondaryTextColor.withOpacity(0.5),
            ),
            ProfileItem(
              icon: 'assets/icon_panduan.svg',
              title: 'Panduan E-Waste',
              press: () {
                Navigator.pushNamed(context, '/panduan-aplikasi');
              },
            ),
            Divider(
              thickness: 1,
              color: secondaryTextColor.withOpacity(0.5),
            ),
            ProfileItem(
              icon: 'assets/icon_snk.svg',
              title: 'Syarat dan Ketentuan',
              press: () {
                Navigator.pushNamed(context, '/syarat-ketentuan');
              },
            ),
            Divider(
              thickness: 1,
              color: secondaryTextColor.withOpacity(0.5),
            ),
            ProfileItem(
              icon: 'assets/icon_bantuan.svg',
              title: 'Pusat Bantuan',
              press: () {
                Navigator.pushNamed(context, '/pusat-bantuan');
              },
            ),
          ],
        ),
      );
    }

    // BUTTON LOGOUT
    Widget buttonLogout() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: CustomButton(
          text: 'Keluar',
          color: primaryColor,
          press: showLogoutDialog,
        ),
      );
    }

    // BUTTON LOADING
    Widget buttonLoading() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: LoadingButton(),
      );
    }

    return Column(
      children: [
        header(),
        profile(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                akun(),
                SizedBox(
                  height: 12,
                ),
                tentang(),
                isLoading ? buttonLoading() : buttonLogout(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
