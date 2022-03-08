import 'dart:async';

import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/custom_text_form_field.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
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
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
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
        margin: EdgeInsets.only(top: 30),
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
        margin: EdgeInsets.only(top: 30),
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
          icon: 'assets/icon_email.svg',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            // NULL
            if (value!.isEmpty) {
              return "Masukkan email";
            }
            // VALID EMAIL
            final pattern =
                r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
            final regExp = RegExp(pattern);

            if (!regExp.hasMatch(value)) {
              return "Masukkan email yang valid";
            }
            return null;
          },
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
              width: double.infinity,
              child: TextFormField(
                cursorColor: primaryTextColor,
                controller: passwordController,
                obscureText: hidden,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukkan kata sandi";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                  hintText: 'Masukkan Kata sandi',
                  hintStyle: hintTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: regular,
                  ),
                  fillColor: backgorundFieldColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  prefixIcon: SvgPicture.asset(
                    'assets/icon_password.svg',
                    width: 10,
                    height: 10,
                    fit: BoxFit.scaleDown,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: passwordHidden,
                    child: SvgPicture.asset(
                      hidden
                          ? 'assets/icon_password_eye_hidden.svg'
                          : 'assets/icon_password_eye.svg',
                      width: 18,
                      height: 18,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
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
          press: () {
            if (formkey.currentState!.validate()) {
              handleLogin();
            }
          },
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
        margin: EdgeInsets.symmetric(vertical: defaultMargin),
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
            child: Form(
              key: formkey,
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
      ),
    );
  }
}
