import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/custom_text_form_field.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(text: '');

  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  TextEditingController confirmPasswordController =
      TextEditingController(text: '');

  bool hidden = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    passwordHidden() async {
      setState(() {
        hidden = !hidden;
      });
    }

    // HANDLE REGISTER
    handleRegister() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redTextColor,
            content: Text(
              'Registrasi Gagal!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    // HEADER
    Widget header() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 95,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ewaste.png'),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Registrasi',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Silahkan lengkapi form berikut,\n pastikan data kamu benar!',
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

    // FORM NAMA
    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: CustomTextFormField(
          title: 'Nama',
          hint: 'Masukkan Nama',
          icon: 'assets/icon_nama.svg',
          controller: nameController,
          validator: (value) {
            // NULL
            if (value!.isEmpty) {
              return "Masukkan nama";
            }

            return null;
          },
        ),
      );
    }

    // FORM EMAIL
    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 15),
        child: CustomTextFormField(
          title: 'Email',
          hint: 'Masukkan Email',
          icon: 'assets/icon_email.svg',
          controller: emailController,
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

    // FORM PASSWORD
    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(top: 15),
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

                  // at least 7 char
                  if (value.length < 8) {
                    return 'Kata sandi harus lebih dari 7 karakter';
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

    // FORM CONFIRM PASSWORD
    Widget confirmPassword() {
      return Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ulang Kata Sandi',
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
                controller: confirmPasswordController,
                obscureText: hidden,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukkan kata sandi";
                  }
                  // at least 7 char
                  if (value != passwordController.text) {
                    return 'Kata sandi tidak sama';
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

    // BUTTON REGISTER
    Widget buttonRegister() {
      return Container(
        margin: EdgeInsets.only(top: 35),
        child: CustomButton(
          text: 'Registrasi',
          color: primaryColor,
          press: () {
            if (formkey.currentState!.validate()) {
              handleRegister();
            }
          },
        ),
      );
    }

    // BUTTON REGISTER
    Widget buttonLoading() {
      return Container(
        margin: EdgeInsets.only(top: 35),
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
              'Sudah punya akun? ',
              style: secondaryTextStyle.copyWith(
                  fontSize: 12, fontWeight: regular),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/login'),
              child: Text(
                ' Masuk',
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
          child: Form(
            key: formkey,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  nameInput(),
                  emailInput(),
                  passwordInput(),
                  confirmPassword(),
                  isLoading ? buttonLoading() : buttonRegister(),
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
