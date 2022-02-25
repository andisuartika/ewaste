import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:ewaste/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    // LOGOUT HANDLE
    handleLogout() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.logout(user.token)) {
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(user.profilePhotoUrl.toString()),
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
        height: 150,
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
          press: handleLogout,
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
