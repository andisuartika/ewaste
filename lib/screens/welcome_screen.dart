import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // HEADER
    Widget header() {
      return Center(
        child: Container(
          margin: EdgeInsets.only(top: 70),
          width: 160,
          height: 160,
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
        ),
      );
    }

    // TEXT
    Widget welcome() {
      return Container(
        margin: EdgeInsets.only(top: 142),
        child: Column(
          children: [
            Text(
              'Selamat Datang!',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Silahkan Login \nuntuk menggunakan aplikasi E-Waste',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // BUTTON LOGIN
    Widget buttonLogin() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: CustomButton(
          text: 'Masuk',
          color: secondaryTextColor,
          press: () => Navigator.pushNamed(context, '/login'),
        ),
      );
    }

    // BUTTON REGISTER
    Widget buttonRegister() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: CustomButton(
          text: 'Registrasi',
          color: primaryColor,
          press: () => Navigator.pushNamed(context, '/register'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              header(),
              welcome(),
              buttonLogin(),
              buttonRegister(),
            ],
          ),
        ),
      ),
    );
  }
}
