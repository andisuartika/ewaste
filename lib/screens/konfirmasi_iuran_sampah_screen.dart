import 'package:ewaste/models/sampah_model.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/perjalanan_provider.dart';
import 'package:ewaste/services/sampah_service.dart';
import 'package:ewaste/services/transaksi_service.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class KonfirmasiIuranSampahScreen extends StatefulWidget {
  final UserModel nasabah;
  final SampahModel sampah;
  final double kuantitas;
  const KonfirmasiIuranSampahScreen(
      {Key? key,
      required this.sampah,
      required this.nasabah,
      required this.kuantitas})
      : super(key: key);

  @override
  _KonfirmasiIuranSampahScreenState createState() =>
      _KonfirmasiIuranSampahScreenState();
}

class _KonfirmasiIuranSampahScreenState
    extends State<KonfirmasiIuranSampahScreen> {
  bool isLoading = false;
  @override
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    PerjalananProvider perjalananProvider =
        Provider.of<PerjalananProvider>(context);

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

      // SET DATA TO API
      var item = [
        {
          'sampah': 6,
          'kuantitas': double.parse(widget.kuantitas.toString()),
        },
      ];

      if (await TransaksiService().transaksiTabungan(
          idNasabah: widget.nasabah.id!,
          item: item,
          idPerjalanan: perjalananProvider.perjalanan.first.id!,
          jenisTransaksi: 'TRANSAKSI IURANS',
          total: int.parse(widget.sampah.harga.toString()))) {
        showSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redTextColor,
            content: Text(
              'Transaksi Gagal dilakukan!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

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
                      widget.nasabah.name.toString(),
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: semiBold,
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        widget.nasabah.alamat.toString(),
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
              authProvider.user.name.toString(),
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
              'Detail Iuran',
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
                      'Sampah ${widget.kuantitas.toString()} Kg',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: regular,
                      ),
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(int.parse(widget.sampah.harga.toString())),
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
                  NumberFormat.currency(
                          locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(int.parse(widget.sampah.harga.toString())),
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
