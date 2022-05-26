import 'dart:math';

import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/sampah_provider.dart';
import 'package:ewaste/screens/konfirmasi_iuran_sampah_screen.dart';
import 'package:ewaste/screens/pembayaran_iuran.dart';
import 'package:ewaste/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    SampahProvider sampahProvider = Provider.of<SampahProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    double width = MediaQuery.of(context).size.width;
    List icons = [
      'assets/icon_js_organik.png',
      'assets/icon_js_plastik.png',
      'assets/icon_js_kertas.png',
      'assets/icon_js_besi.png',
      'assets/icon_js_kaca.png',
    ];
    // HEADER
    Widget header() {
      return Container(
        height: 200,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.03),
              spreadRadius: 5,
              blurRadius: 0,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: (width - 75) / 2,
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_tabungan.png',
                    width: 35,
                    height: 35,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Text(
                          'Total Tabungan',
                          style: primaryTextStyle.copyWith(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp',
                          decimalDigits: 0,
                        ).format(2500000),
                        style: greenTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: (width - 75) / 2,
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_tarik.png',
                    width: 35,
                    height: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Text(
                          'Total Ditarik',
                          style: primaryTextStyle.copyWith(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp',
                          decimalDigits: 0,
                        ).format(500000),
                        style: greenTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    // IURAN SAMPAH
    Widget iuranSampah() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: 30,
          right: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Tabungan Sampah',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PembayaraniuranScreen(
                      user: user,
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 65,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: backgorundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage("assets/icon_js_iuran.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Iuran Sampah",
                        style: greenTextStyle.copyWith(
                          color: redTextColor,
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                    Text(
                      user.iurans == null
                          ? "Rp0"
                          : NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp',
                              decimalDigits: 0,
                            ).format(int.parse(user.iurans.toString())),
                      style: primaryTextStyle.copyWith(
                        color: redTextColor,
                        fontSize: 16,
                        fontWeight: semiBold,
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

    // DETAIL TABUNGAN SAMPAH
    Widget detailTabungan() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: 30,
          right: 30,
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Tabungan Sampah',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Column(children: [
              ...sampahProvider.sampah
                  .map(
                    (sampah) => Container(
                      width: double.infinity,
                      height: 65,
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: backgorundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(icons[sampah.id! - 1]),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              sampah.nama.toString(),
                              style: greenTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: medium,
                              ),
                            ),
                          ),
                          Text(
                            '${Random().nextInt(100 - 5)}Kg',
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ]),
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
          'Tabungan',
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
      body: Column(
        children: [
          header(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  int.parse(user.iurans!) > 0 ? iuranSampah() : SizedBox(),
                  detailTabungan(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
