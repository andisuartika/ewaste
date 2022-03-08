import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/screens/home/main_screen.dart';
import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UbahPasswordScreen extends StatefulWidget {
  const UbahPasswordScreen({Key? key}) : super(key: key);

  @override
  _UbahPasswordScreenState createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  final formkey = GlobalKey<FormState>();
  // TEXT EDITING CONTROLLER
  TextEditingController currentPassController = TextEditingController(text: '');
  TextEditingController newPassController = TextEditingController(text: '');
  TextEditingController confrimNewPassController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    // DIALOG
    Future<void> showMessDialog(bool success) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    success
                        ? 'assets/icon_success.svg'
                        : 'assets/icon_alert.svg',
                    color: success ? primaryColor : redTextColor,
                    width: 80,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    success ? 'Berhasil!' : 'Gagal!',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    success
                        ? 'kata sandi berhasil diubah'
                        : 'kata sandi lama salah',
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 145,
                    height: 44,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScrenn(
                              pageIndex: 4,
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: success ? primaryColor : redTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Lanjut',
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // GANTI KATA SANDI HANDLE
    handleChangePassword() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.changePassword(
        email: user.email.toString(),
        password: currentPassController.text,
        newPassword: newPassController.text,
        token: user.token.toString(),
      )) {
        showMessDialog(true);
      } else {
        showMessDialog(false);
      }

      setState(() {
        isLoading = false;
      });
    }

    // TITLE
    Widget title() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ganti kata sandi kamu',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Silahkan masukkan kata sandi saat ini dan buat kata sandi baru.',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
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
          'Ganti Kata Sandi',
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
      body: Form(
        key: formkey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              title(),
              FormPassBuild(
                title: 'Kata sandi saat ini',
                hint: 'Masukkan kata sandi saat ini',
                controller: currentPassController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukkan kata sandi saat ini";
                  }
                  return null;
                },
              ),
              FormPassBuild(
                title: 'Kata sandi baru',
                hint: 'Masukkan kata sandi baru',
                controller: newPassController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukkan kata sandi baru";
                  }
                  // at least 7 char
                  if (value.length < 8) {
                    return 'Kata sandi harus lebih dari 7 karakter';
                  }
                  return null;
                },
              ),
              FormPassBuild(
                title: 'Ulang kata sandi baru',
                hint: 'Masukkan ulang kata sandi baru',
                controller: confrimNewPassController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukkan ulang kata sandi baru";
                  }

                  // at least 7 char
                  if (value != newPassController.text) {
                    return 'Kata sandi baru tidak sama';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: CustomButton(
          text: 'Ganti Kata sandi',
          color: primaryColor,
          press: () {
            if (formkey.currentState!.validate()) {
              handleChangePassword();
            }
          },
        ),
      ),
    );
  }
}

class FormPassBuild extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final validator;
  const FormPassBuild({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<FormPassBuild> createState() => _FormPassBuildState();
}

class _FormPassBuildState extends State<FormPassBuild> {
  @override
  bool hidden = true;

  // HIDDEN PASSWORD
  passwordHidden() async {
    setState(() {
      hidden = !hidden;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
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
              controller: widget.controller,
              obscureText: hidden,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                hintText: widget.hint,
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
}
