import 'package:ewaste/theme.dart';
import 'package:flutter/material.dart';

class VersiAplikasiScreen extends StatefulWidget {
  const VersiAplikasiScreen({Key? key}) : super(key: key);

  @override
  State<VersiAplikasiScreen> createState() => _VersiAplikasiScreenState();
}

class _VersiAplikasiScreenState extends State<VersiAplikasiScreen> {
  @override
  Widget build(BuildContext context) {
    // LOGO
    Widget logo() {
      return Container(
        width: double.infinity,
        height: 200,
        margin: EdgeInsets.only(
          top: 50,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 128,
              height: 122,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ewaste.png'),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '- Sampah jadi Rupiah -',
              style: darkGreenTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            )
          ],
        ),
      );
    }

    // TENTANG
    Widget tentang() {
      return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'E-WASTE',
              style: darkGreenTextStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'E-Waste merupakan aplikasi manajemen sampah yang dikelola oleh bank sampah dan nasabah dapat menabung sekaligus melihat tabungan sampahnya dengan aplikasi E-Waste.',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
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
          'Versi Aplikasi',
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            logo(),
            Expanded(
              child: tentang(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  Text(
                    'Versi Aplikasi saat ini',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '1.0.0',
                    style: darkGreenTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
