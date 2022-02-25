import 'package:ewaste/theme.dart';
import 'package:flutter/material.dart';

class PanduanAplikasiScren extends StatelessWidget {
  const PanduanAplikasiScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PANDUAN PENGGUNAAN APLIKASI
    Widget panduan() {
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
              'Panduan Penggunaan Aplikasi',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Berikut merupakan panduan dasar penggunaan aplikasi E-Waste untuk nasabah baru.',
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

    // PENDAFTARAN NASABAH
    Widget pandaftaranNasabah() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pendaftaran Nasabah',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Nasabah bisa melakukan registrasi melalui aplikasi E-Waste dan melakukan aktivasi akun pada bank sampah setempat untuk dapat menjadi nasabah aktif E-Waste. ',
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

    // NABUNG NASABAH
    Widget nabungNasabah() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nabung Sampah',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Nasabah dapat menabung sampah apabila akun sudah aktif dan nantinya petugas sampah akan langsung melakukan penjemputan sampah ke rumah nasabah sesuai dengan jadwal yang sudah ditentukan oleh pengelola bank sampah.',
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

    // PENCAIRAN SALDO
    Widget pencairanSaldo() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pencairan Saldo',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Untuk melakukan pencairan saldo nasabah dapat melakukan pencairan pada halaman beranda aplikasi melalui tombol tarik saldo dapat dilakukan dengan pencairan ke bank atau E-Wallet nasabah (Syarat dan Ketentuan Berlaku).',
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

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Panduan Aplikasi',
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
              panduan(),
              pandaftaranNasabah(),
              nabungNasabah(),
              pencairanSaldo(),
            ],
          ),
        ),
      ),
    );
  }
}
