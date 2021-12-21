import 'package:ewaste/theme.dart';
import 'package:flutter/material.dart';

class InputSampahScreen extends StatelessWidget {
  const InputSampahScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SAMPAH TERPILAH
    Widget terpilah() {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/sampah-terpilah'),
        child: Container(
          margin: EdgeInsets.only(top: 50),
          width: double.infinity,
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
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
            children: [
              Image.asset(
                'assets/icon_sampah_terpilah.png',
                width: 35,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'Sampah sudah terpilah',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              Image.asset(
                'assets/icon_arrow_right.png',
                width: 24,
              ),
            ],
          ),
        ),
      );
    }

    // SAMPAH CAMPURAN
    Widget campuran() {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/sampah-campuran'),
        child: Container(
          margin: EdgeInsets.only(top: 30),
          width: double.infinity,
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
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
            children: [
              Image.asset(
                'assets/icon_sampah_campuran.png',
                width: 35,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'Sampah Campuran',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              Image.asset(
                'assets/icon_arrow_right.png',
                width: 24,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Jenis Sampah',
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
            terpilah(),
            campuran(),
          ],
        ),
      ),
    );
  }
}
