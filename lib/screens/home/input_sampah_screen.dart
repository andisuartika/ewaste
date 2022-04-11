import 'package:ewaste/models/nasabah_model.dart';
import 'package:ewaste/screens/sampah_campuran_screen.dart';
import 'package:ewaste/screens/sampah_terpilah_screen.dart';
import 'package:ewaste/theme.dart';
import 'package:flutter/material.dart';

class InputSampahScreen extends StatefulWidget {
  final NasabahModel nasabah;

  InputSampahScreen({Key? key, required this.nasabah}) : super(key: key);

  @override
  State<InputSampahScreen> createState() => _InputSampahScreenState();
}

class _InputSampahScreenState extends State<InputSampahScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.nasabah.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SAMPAH TERPILAH
    Widget terpilah() {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SampahTerpilahScreen(nasabah: widget.nasabah),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(top: 50),
          width: double.infinity,
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: secondaryTextColor),
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SampahCampuranScreen(nasabah: widget.nasabah),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(top: 30),
          width: double.infinity,
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: secondaryTextColor),
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
      backgroundColor: whiteColor,
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
