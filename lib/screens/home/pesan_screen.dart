import 'package:ewaste/widgets/custom_pesan_item.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class PesanScreen extends StatelessWidget {
  const PesanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // HEADER
    Widget header() {
      return AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Notifikasi',
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
    Widget pesan() {
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
              CustomPesanItem(
                date: '10 Nov 2021 13:00',
                pesan:
                    'Kamu berhasil manabung sampah, cek points yang sudah kamu kampulkan sekarang',
              ),
              CustomPesanItem(
                date: '10 Nov 2021 13:00',
                pesan:
                    'Kamu berhasil menukarkan points kamu dengan uang tunaj, jangan lupa menabung lagi :)',
              ),
              CustomPesanItem(
                date: '10 Nov 2021 13:00',
                pesan:
                    'Yuk nabung sampah lagi, kumpulkan points kamu sebanyak banyaknya',
              ),
              CustomPesanItem(
                date: '10 Nov 2021 13:00',
                pesan:
                    'Kamu berhasil manabung sampah, cek points yang sudah kamu kampulkan sekarang',
              ),
              CustomPesanItem(
                date: '10 Nov 2021 13:00',
                pesan:
                    'Kamu berhasil manabung sampah, cek points yang sudah kamu kampulkan sekarang',
              ),
              CustomPesanItem(
                date: '10 Nov 2021 13:00',
                pesan:
                    'Kamu berhasil manabung sampah, cek points yang sudah kamu kampulkan sekarang',
              ),
              CustomPesanItem(
                date: '10 Nov 2021 13:00',
                pesan:
                    'Kamu berhasil manabung sampah, cek points yang sudah kamu kampulkan sekarang',
              ),
              CustomPesanItem(
                date: '10 Nov 2021 13:00',
                pesan:
                    'Kamu berhasil manabung sampah, cek points yang sudah kamu kampulkan sekarang',
              ),
              CustomPesanItem(
                date: '10 Nov 2021 13:00',
                pesan:
                    'Kamu berhasil manabung sampah, cek points yang sudah kamu kampulkan sekarang',
              ),
            ],
          ),
        ),
      );
    }

    // PESAN EMPTY
    Widget empty() {
      return Expanded(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image_empty_pesan.png',
                width: 80,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Yahh, Belum ada pesan nih...',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
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
        pesan(),
        // empty(),
      ],
    );
  }
}
