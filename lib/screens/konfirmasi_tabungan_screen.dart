import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/detail_transaksi_item.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class KonfirmasiTabunganScreen extends StatefulWidget {
  const KonfirmasiTabunganScreen({Key? key}) : super(key: key);

  @override
  State<KonfirmasiTabunganScreen> createState() =>
      _KonfirmasiTabunganScreenState();
}

class _KonfirmasiTabunganScreenState extends State<KonfirmasiTabunganScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
    Widget tabunganTitle() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Text(
          'Tabungan Sampah',
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
                  'assets/icon_tabung_sampah.png',
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
    Widget detailTabungan() {
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
            DetailTransaksiItem(
              sampah: 'Organik',
              jumlah: 5,
              harga: 250,
              total: 1250,
            ),
            DetailTransaksiItem(
              sampah: 'Plastik',
              jumlah: 10,
              harga: 2000,
              total: 20000,
            ),
            DetailTransaksiItem(
              sampah: 'Kertas',
              jumlah: 3,
              harga: 1500,
              total: 4500,
            ),
            DetailTransaksiItem(
              sampah: 'Besi',
              jumlah: 15,
              harga: 1600,
              total: 24000,
            ),
            DetailTransaksiItem(
              sampah: 'Pecah Belah',
              jumlah: 5,
              harga: 500,
              total: 2500,
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
                    'Total tabungan',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                ),
                Text(
                  'Rp 52.250',
                  style: primaryTextStyle.copyWith(
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
          'Konfirmasi Tabungan',
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
            tabunganTitle(),
            nasabah(),
            petugas(),
            detailTabungan(),
            isLoading ? buttonLoading() : buttonKonfirmasi(),
          ],
        ),
      ),
    );
  }
}
