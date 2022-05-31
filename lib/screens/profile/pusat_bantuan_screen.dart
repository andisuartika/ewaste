import 'package:ewaste/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme.dart';

class PusatBantuanScreen extends StatefulWidget {
  const PusatBantuanScreen({Key? key}) : super(key: key);

  @override
  State<PusatBantuanScreen> createState() => _PusatBantuanScreenState();
}

class _PusatBantuanScreenState extends State<PusatBantuanScreen> {
  @override
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

  Widget build(BuildContext context) {
    // TITLE
    Widget title() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 50,
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pusat Bantuan',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Butuh bantuan? jika kamu mengalami kendala saat pemakaian aplikasi E-Waste bisa kamu tanyakan pada kami melalui salah satu platform berikut ya!',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      );
    }

    // KONTAK
    Widget kontak() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hubungi Kami',
            style: primaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(height: 20),
          ProfileItem(
              icon: 'assets/icon_cs_email.svg',
              title: 'ewaste@gmail.com',
              press: () {
                var email = 'ewaste@gmail.com';
                var url = 'https://mailto:' + email;
                _launch(url);
              }),
          Divider(
            thickness: 1,
            color: secondaryTextColor.withOpacity(0.5),
          ),
          ProfileItem(
            icon: 'assets/icon_cs_wa.svg',
            title: '0831-5940-9155',
            press: () {
              var url =
                  'https://wa.me/6283159409115?text=Hi%20admin%20E-Waste%20Bali,%20';

              _launch(url);
            },
          ),
          Divider(
            thickness: 1,
            color: secondaryTextColor.withOpacity(0.5),
          ),
          ProfileItem(
            icon: 'assets/icon_cs_fb.svg',
            title: 'ewastebali',
            press: () {
              var url = 'https://facebook.com';
              _launch(url);
            },
          ),
          Divider(
            thickness: 1,
            color: secondaryTextColor.withOpacity(0.5),
          ),
          ProfileItem(
            icon: 'assets/icon_cs_telp.svg',
            title: '0831-5940-9155',
            press: () {
              var phone = '085728614399';
              var url = 'tel:' + phone;

              _launch(url);
            },
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Pusat Bantuan',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              title(),
              kontak(),
            ],
          ),
        ),
      ),
    );
  }
}
