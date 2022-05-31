import 'package:ewaste/theme.dart';
import 'package:flutter/material.dart';

class SyaratdanKetentuanScreen extends StatelessWidget {
  const SyaratdanKetentuanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CONTENT
    Widget content() {
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
              'Syarat dan Ketentuan E-Waste',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Pengguna diwajibkan untuk membaca seluruh Syarat dan Ketentuan ini dengan seksama, dan dapat menghubungi pihak E-Waste jika memiliki pertanyaan.',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 15),
            Text(
              'Syarat dan Ketentuan ini mengatur pemakaian dan akses pengguna terhadap aplikasi, website, konten yang disediakan oleh E-Waste. Dengan mengakses atau menggunakan aplikasi layanan E-Waste, Pengguna setuju dan mematuhi “Syarat dan ketentuan Aplikasi E-Waste.',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Definisi',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'E-Waste adalah aplikasi sistem pengelolaan bank sampah yang dimana nasabah dapat menabung sampah dan melihat saldo yang telah dikumpulkan pada aplikai E-Waste.',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 15),
            Text(
              'Nasabah adalah pengguna yang telah terdaftar dan aktif menjadi kelompok bank sampah.',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Ketentuan Umum',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'E-Waste dapat digunakan setelah pengguna menyetujui syarat dan ketentuan yang berlaku pada aplikasi E-Waste.',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 15),
            Text(
              'Pengguna dapat mendaftarkan akun E-Waste dengan Email yang aktif dan hanya dapat dilakukan untuk pendaftaran 1(satu) akun.',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 15),
            Text(
              'Nasabah dapat menabung sampah yang dilakukan oleh petugas sampah yang dijemput ke rumah nasabah sesuai dengan jadwal yang ditentukan',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 15),
            Text(
              'Nasabah dapat melakukan pencairan saldo tabungan setelah memiliki minimal Rp50.000 saldo yang telah dikumpulkan dari hasil menabung sampah.',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 15),
            Text(
              'Pencairan saldo dapat dilakukan melalui rekening bank atau E-Wallet yang sudah disedian oleh pihak E-Waste.',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
            ),
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
          'Syarat dan Ketentuan',
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
              content(),
            ],
          ),
        ),
      ),
    );
  }
}
