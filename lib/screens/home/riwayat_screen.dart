import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/custom_riwayat_item.dart';
import 'package:flutter/material.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // HEADER
    Widget header() {
      return AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Riwayat Transaksi',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    // RIWAYAT CONTENT
    Widget riwayat() {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(
            right: 30,
            left: 30,
            bottom: 30,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              CustomRiwayatItem(
                image: 'assets/icon_riwayat_menabung.png',
                title: 'Menabung Sampah',
                date: '10 November 2021 13:00',
                nominal: 10000,
                color: primaryColor,
              ),
              CustomRiwayatItem(
                image: 'assets/icon_riwayat_menabung.png',
                title: 'Menabung Sampah',
                date: '10 November 2021 13:00',
                nominal: 20000,
                color: primaryColor,
              ),
              CustomRiwayatItem(
                image: 'assets/icon_riwayat_tarik.png',
                title: 'Tarik Tunai',
                date: '10 November 2021 13:00',
                nominal: 50000,
                color: redTextColor,
              ),
              CustomRiwayatItem(
                image: 'assets/icon_riwayat_menabung.png',
                title: 'Menabung Sampah',
                date: '10 November 2021 13:00',
                nominal: 30000,
                color: primaryColor,
              ),
              CustomRiwayatItem(
                image: 'assets/icon_riwayat_menabung.png',
                title: 'Menabung Sampah',
                date: '10 November 2021 13:00',
                nominal: 10000,
                color: primaryColor,
              ),
              CustomRiwayatItem(
                image: 'assets/icon_riwayat_tarik.png',
                title: 'Tarik Tunai',
                date: '10 November 2021 13:00',
                nominal: 30000,
                color: redTextColor,
              ),
              CustomRiwayatItem(
                image: 'assets/icon_riwayat_menabung.png',
                title: 'Menabung Sampah',
                date: '10 November 2021 13:00',
                nominal: 10000,
                color: primaryColor,
              ),
            ],
          ),
        ),
      );
    }

    // RIWAYAT EMPTY
    Widget empty() {
      return Expanded(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image_empty_riwayat.png',
                width: 80,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Kamu belum melakukan transaksi',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Yuk mulai menabung sampah',
                style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: regular,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        // riwayat(),
        empty(),
      ],
    );
  }
}
