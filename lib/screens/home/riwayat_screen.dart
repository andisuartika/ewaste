import 'package:ewaste/models/transaksi_model.dart';
import 'package:ewaste/providers/all_perjalanan_provider.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/transaksi_provider.dart';
import 'package:ewaste/services/transaksi_service.dart';
import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/custom_perjalanan_item.dart';
import 'package:ewaste/widgets/custom_riwayat_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({Key? key}) : super(key: key);

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TransaksiProvider transaksiProvider =
        Provider.of<TransaksiProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AllPerjalananProvider allPerjalananProvider =
        Provider.of<AllPerjalananProvider>(context);

    // HEADER
    Widget header() {
      return AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          authProvider.user.roles == 'PETUGAS'
              ? 'Riwayat Perjalanan'
              : 'Riwayat Transaksi',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    // RIWAYAT CONTENT
    Widget riwayat() {
      return Expanded(
        child: Consumer<TransaksiProvider>(
          builder: (context, transaksi, child) => Container(
            margin: EdgeInsets.only(
              right: 30,
              left: 30,
              bottom: 30,
              top: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: transaksi.transaksi
                    .map((transaksi) => CustomRiwayatItem(transaksi: transaksi))
                    .toList(),
              ),
            ),
          ),
        ),
      );
    }

    // RIWAYAT CONTENT
    Widget perjalanan() {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(
            right: 30,
            left: 30,
            bottom: 30,
            top: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: allPerjalananProvider.perjalanan
                  .map(
                    (perjalanan) =>
                        CustomPerjalananItem(perjalanan: perjalanan),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    }

    // RIWAYAT EMPTY
    Widget emptyRiwayat() {
      return Expanded(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/image_empty_riwayat.png',
                      width: 80,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Kamu belum melakukan transaksi',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Yuk mulai menabung sampah',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
      );
    }

    return Column(
      children: [
        header(),
        authProvider.user.roles == 'PETUGAS'
            ? Container(
                child: perjalanan(),
              )
            : Container(
                child: transaksiProvider.transaksi.isEmpty
                    ? emptyRiwayat()
                    : riwayat(),
              )
      ],
    );
  }
}
