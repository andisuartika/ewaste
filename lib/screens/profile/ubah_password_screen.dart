import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UbahPasswordScreen extends StatefulWidget {
  const UbahPasswordScreen({Key? key}) : super(key: key);

  @override
  _UbahPasswordScreenState createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  // TEXT EDITING CONTROLLER
  TextEditingController currentPassController = TextEditingController(text: '');
  TextEditingController newPassController = TextEditingController(text: '');
  TextEditingController confrimNewPassController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            title(),
            FormPassBuild(
              title: 'Kata sandi saat ini',
              hint: 'Masukkan kata sandi saat ini',
              controller: currentPassController,
            ),
            FormPassBuild(
              title: 'Kata sandi baru',
              hint: 'Masukkan kata sandi baru',
              controller: newPassController,
            ),
            FormPassBuild(
              title: 'Ulang kata sandi baru',
              hint: 'Masukkan ulang kata sandi baru',
              controller: confrimNewPassController,
            ),
          ],
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
          press: () {},
        ),
      ),
    );
  }
}

class FormPassBuild extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  const FormPassBuild({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
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
                  SvgPicture.asset(
                    'assets/icon_password.svg',
                    width: 20,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      obscureText: hidden,
                      style: primaryTextStyle,
                      controller: widget.controller,
                      decoration: InputDecoration.collapsed(
                        hintText: widget.hint,
                        hintStyle: hintTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: passwordHidden,
                    child: SvgPicture.asset(
                      hidden
                          ? 'assets/icon_password_eye_hidden.svg'
                          : 'assets/icon_password_eye.svg',
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
}
