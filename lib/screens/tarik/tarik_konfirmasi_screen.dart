import 'package:flutter/material.dart';

import '../../theme.dart';

class TarikKonfirmasiScreen extends StatefulWidget {
  final int idBank;
  final String norek;
  final String name;
  final int nominal;
  const TarikKonfirmasiScreen({
    Key? key,
    required this.idBank,
    required this.norek,
    required this.name,
    required this.nominal,
  }) : super(key: key);

  @override
  State<TarikKonfirmasiScreen> createState() => _TarikKonfirmasiScreenState();
}

class _TarikKonfirmasiScreenState extends State<TarikKonfirmasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Konfirmasi',
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
      ),
    );
  }
}
