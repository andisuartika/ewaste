import 'package:ewaste/models/sampah_model.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/perjalanan_provider.dart';
import 'package:ewaste/providers/sampah_provider.dart';
import 'package:ewaste/services/transaksi_service.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/detail_transaksi_item.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class KonfirmasiTabunganScreen extends StatefulWidget {
  final UserModel nasabah;
  final String organik;
  final String plastik;
  final String kertas;
  final String logam;
  final String kaca;
  const KonfirmasiTabunganScreen({
    Key? key,
    required this.nasabah,
    required this.organik,
    required this.plastik,
    required this.kertas,
    required this.logam,
    required this.kaca,
  }) : super(key: key);

  @override
  State<KonfirmasiTabunganScreen> createState() =>
      _KonfirmasiTabunganScreenState();
}

class _KonfirmasiTabunganScreenState extends State<KonfirmasiTabunganScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    SampahProvider sampahProvider = Provider.of<SampahProvider>(context);
    PerjalananProvider perjalananProvider =
        Provider.of<PerjalananProvider>(context);

    double organik = double.parse(widget.organik);
    double plastik = double.parse(widget.plastik);
    double kertas = double.parse(widget.kertas);
    double logam = double.parse(widget.logam);
    double kaca = double.parse(widget.kaca);

    int hargaOrganik = int.parse(sampahProvider.sampah[0].harga.toString());
    int hargaPlastik = int.parse(sampahProvider.sampah[1].harga.toString());
    int hargaKertas = int.parse(sampahProvider.sampah[2].harga.toString());
    int hargaLogam = int.parse(sampahProvider.sampah[3].harga.toString());
    int hargaKaca = int.parse(sampahProvider.sampah[4].harga.toString());

    double totalOrganik = organik * hargaOrganik;
    double totalPlastik = plastik * hargaPlastik;
    double totalKertas = kertas * hargaKertas;
    double totalLogam = logam * hargaLogam;
    double totalKaca = kaca * hargaKaca;

    double total =
        totalOrganik + totalPlastik + totalKertas + totalLogam + totalKaca;

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
          'sampah': 1,
          'kuantitas': organik,
        },
        {
          'sampah': 2,
          'kuantitas': plastik,
        },
        {
          'sampah': 3,
          'kuantitas': kertas,
        },
        {
          'sampah': 4,
          'kuantitas': logam,
        },
        {
          'sampah': 5,
          'kuantitas': kaca,
        },
      ];

      if (await TransaksiService().transaksiTabungan(
        idNasabah: widget.nasabah.id!,
        item: item,
        idPerjalanan: perjalananProvider.perjalanan.first.id!,
        jenisTransaksi: 'TRANSAKSI MASUK',
        total: total.toInt(),
      )) {
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
              jumlah: organik,
              harga: hargaOrganik,
              total: organik * hargaOrganik,
            ),
            DetailTransaksiItem(
              sampah: 'Plastik',
              jumlah: plastik,
              harga: hargaPlastik,
              total: plastik * hargaPlastik,
            ),
            DetailTransaksiItem(
              sampah: 'Kertas',
              jumlah: kertas,
              harga: hargaKertas,
              total: kertas * hargaKertas,
            ),
            DetailTransaksiItem(
              sampah: 'Besi',
              jumlah: logam,
              harga: hargaLogam,
              total: logam * hargaLogam,
            ),
            DetailTransaksiItem(
              sampah: 'Pecah Belah',
              jumlah: kaca,
              harga: hargaKaca,
              total: kaca * hargaKaca,
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
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(total),
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
