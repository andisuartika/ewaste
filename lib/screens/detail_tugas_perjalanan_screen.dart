import 'package:ewaste/models/perjalanan_model.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/perjalanan_provider.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class DetailTugasPerjalananScreen extends StatefulWidget {
  final PerjalananModel perjalanan;
  const DetailTugasPerjalananScreen({Key? key, required this.perjalanan})
      : super(key: key);

  @override
  State<DetailTugasPerjalananScreen> createState() =>
      _DetailTugasPerjalananScreenState();
}

class _DetailTugasPerjalananScreenState
    extends State<DetailTugasPerjalananScreen> {
  bool isLoading = false;
  String status = '';
  @override
  void initState() {
    setState(() {
      if (widget.perjalanan.status == 'DIJADWALKAN') {
        status = 'DIKERJAKAN';
      }
      if (widget.perjalanan.status == 'DIKERJAKAN') {
        status = 'SELESAI';
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    // SUCCESS DIALOG
    Future<void> showSuccessDialog() async {
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
                  Image.asset(
                    'assets/icon_success.png',
                    width: 100,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    status == 'DIKERJAKAN'
                        ? 'Selamat Bertugas'
                        : 'Terima Kasih',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    status == 'DIKERJAKAN'
                        ? 'Tugas perjalanan kamu sudah diupdate'
                        : 'Tugas perjalanan kamu siap untuk divalidasi',
                    style: secondaryTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 154,
                    height: 44,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/main');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Beranda',
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

    handlePerjalanan() async {
      setState(() {
        isLoading = true;
      });
      int id = widget.perjalanan.id!;
      print(status);
      if (await PerjalananProvider().updatePerjalanan(status: status, id: id)) {
        showSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redTextColor,
            content: Text(
              'Gagal Update Tugas Perjalnan',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    // RINCIAN PENARIKAN
    Widget detailPerjalanan() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Tugas Perjalanan',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name.toString(),
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Status :',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                  Text(
                    widget.perjalanan.status.toString(),
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Kode Perjalanan :',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                  Text(
                    widget.perjalanan.kode.toString(),
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Waktu Tugas :',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                  Text(
                    widget.perjalanan.waktuTugas.toString(),
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Waktu Selesai :',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                  Text(
                    widget.perjalanan.waktuSelesai == null
                        ? '-'
                        : widget.perjalanan.waktuSelesai.toString(),
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Keterangan :',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                  Text(
                    widget.perjalanan.keterangan.toString(),
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(height: 3),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Tugas Perjalanan',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/main'),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            detailPerjalanan(),
          ],
        ),
      ),
      bottomNavigationBar: widget.perjalanan.waktuSelesai != null
          ? Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: isLoading
                  ? LoadingButton()
                  : CustomButton(
                      text: 'Selesai',
                      color: secondaryTextColor,
                      press: () {},
                    ),
            )
          : Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: isLoading
                  ? LoadingButton()
                  : CustomButton(
                      text: status == 'DIKERJAKAN' ? 'Kerjakan' : 'Selesai',
                      color: primaryColor,
                      press: () {
                        handlePerjalanan();
                      },
                    ),
            ),
    );
  }
}
