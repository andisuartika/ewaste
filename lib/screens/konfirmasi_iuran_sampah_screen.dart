import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme.dart';

class KonfirmasiIuranSampahScreen extends StatefulWidget {
  const KonfirmasiIuranSampahScreen({Key? key}) : super(key: key);

  @override
  _KonfirmasiIuranSampahScreenState createState() =>
      _KonfirmasiIuranSampahScreenState();
}

class _KonfirmasiIuranSampahScreenState
    extends State<KonfirmasiIuranSampahScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    // DIALOG
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
                    'Terima Kasih',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Transaksi Berhasil disimpan',
                    style: secondaryTextStyle,
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

    // HANDLE KONFIRMASI
    handleKonfirmasi() async {
      setState(() {
        isLoading = true;
      });
      showSuccessDialog();

      setState(() {
        isLoading = false;
      });
    }

    // TABUNGAN TITLE
    Widget sampahTitle() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Text(
          'Biaya Pengangkutan Sampah',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    // NASABAH
    Widget nasabah() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nasabah',
              style: secondaryTextStyle.copyWith(
                fontSize: 10,
                fontWeight: regular,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/icon_pengangkutan_sampah.png',
                  width: 50,
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Putu Andi Suartika',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: semiBold,
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        'Jalan Pratu Praupan Sangket Sukasada Buleleng Bali',
                        style: secondaryTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: light,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    // PETUGAS SAMPAH
    Widget petugas() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Petugas',
              style: secondaryTextStyle.copyWith(
                fontSize: 10,
                fontWeight: regular,
              ),
            ),
            Text(
              'Komang Artawan',
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    // DETAIL TABUNGAN
    Widget detailPembayaran() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Tabungan',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Sampah 25Kg ' +
                          '( ' +
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(500) +
                          ' )',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: regular,
                      ),
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(12500),
                    style: secondaryTextStyle.copyWith(
                      color: redTextColor,
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: secondaryTextColor,
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Total Pembayaran',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                ),
                Text(
                  'Rp 12.500',
                  style: primaryTextStyle.copyWith(
                    color: redTextColor,
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // KONFIRMASI BUTTON
    Widget buttonKonfirmasi() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: CustomButton(
          text: 'Konfirmasi',
          color: primaryColor,
          press: handleKonfirmasi,
        ),
      );
    }

    // LOADING BUTTON
    Widget buttonLoading() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: LoadingButton(),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Konfirmasi Sampah',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sampahTitle(),
            nasabah(),
            petugas(),
            detailPembayaran(),
            isLoading ? buttonLoading() : buttonKonfirmasi(),
          ],
        ),
      ),
    );
  }
}
