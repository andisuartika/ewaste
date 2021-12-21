import 'dart:async';

import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/custom_text_form_field.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  bool hidden = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    // LOGIN HANDLE
    handleLogin() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamed(context, '/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redTextColor,
            content: Text(
              'Gagal Login!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      // GO TO MAIN SCREEN
      // Timer(Duration(seconds: 3), () {
      //   Navigator.pushNamed(context, '/main');
      // });

      setState(() {
        isLoading = false;
      });
    }

    // HIDDEN PASSWORD
    passwordHidden() async {
      setState(() {
        hidden = !hidden;
      });
    }

    // HEADER
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 70),
        width: double.infinity,
        child: Column(
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
            ),
          ],
        ),
      );
    }

    // LOGIN TEXT
    Widget textLogin() {
      return Container(
        margin: EdgeInsets.only(top: 70),
        child: Column(
          children: [
            Text(
              'MASUK',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
                letterSpacing: 2,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              'Silahkan Masukkan Email dan kata sandi kamu \nyang sudah terdaftar ya!',
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // EMAIL INPUT
    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 25),
        child: CustomTextFormField(
          title: 'Email',
          hint: 'Masukkan Email',
          icon: 'assets/icon_email.png',
          controller: emailController,
        ),
      );
    }

    // PASSWORD INPUT
    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kata Sandi',
              style: darkGreenTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgorundFieldColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon_password.png',
                      width: 20,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        obscureText: hidden,
                        style: primaryTextStyle,
                        controller: passwordController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukkan Kata sandi',
                          hintStyle: hintTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: passwordHidden,
                      child: Image.asset(
                        hidden
                            ? 'assets/icon_password_eye_hidden.png'
                            : 'assets/icon_password_eye.png',
                        width: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // BUTTON LOGIN
    Widget buttonLogin() {
      return Container(
        margin: EdgeInsets.only(top: 60),
        child: CustomButton(
          text: 'Masuk',
          color: primaryColor,
          press: handleLogin,
        ),
      );
    }

    // BUTTON LOGIN
    Widget buttonLoading() {
      return Container(
        margin: EdgeInsets.only(top: 60),
        child: LoadingButton(),
      );
    }

    // FOOTER
    Widget footer() {
      return Container(
        margin: EdgeInsets.only(top: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun? ',
              style: secondaryTextStyle.copyWith(
                  fontSize: 12, fontWeight: regular),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/register'),
              child: Text(
                ' Registrasi',
                style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              children: [
                header(),
                textLogin(),
                emailInput(),
                passwordInput(),
                isLoading ? buttonLoading() : buttonLogin(),
                footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
