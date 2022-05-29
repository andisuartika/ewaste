import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ewaste/models/nasabah_model.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/screens/konfirmasi_tabungan_screen.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/custom_text_form_tabungan.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class SampahTerpilahScreen extends StatefulWidget {
  final UserModel nasabah;
  const SampahTerpilahScreen({Key? key, required this.nasabah})
      : super(key: key);

  @override
  State<SampahTerpilahScreen> createState() => _SampahTerpilahScreenState();
}

class _SampahTerpilahScreenState extends State<SampahTerpilahScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController kodeController = TextEditingController(text: '');
  TextEditingController nasabahController = TextEditingController(text: '');
  TextEditingController organikController = TextEditingController(text: '');
  TextEditingController plastikController = TextEditingController(text: '');
  TextEditingController kertasController = TextEditingController(text: '');
  TextEditingController besiController = TextEditingController(text: '');
  TextEditingController kacaController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    // HANDLE SAVE
    handleSimpan() async {
      setState(() {
        isLoading = true;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KonfirmasiTabunganScreen(
              nasabah: widget.nasabah,
              organik: organikController.text,
              plastik: plastikController.text,
              kertas: kertasController.text,
              logam: besiController.text,
              kaca: kacaController.text),
        ),
      );

      setState(() {
        isLoading = false;
      });
    }

    // HEADER
    Widget header() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PETUGAS
            Container(
              child: Row(
                children: [
                  // AVATAR IMAGE
                  ClipOval(
                    child: user.profilePhotoPath == null
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: secondaryTextColor,
                                width: 1,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'http://wastebali.com/storage/usersProfile/user.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: user.profilePhotoUrl.toString(),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Petugas',
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        user.name.toString().toUpperCase(),
                        style: secondaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              child: DottedLine(
                dashLength: 8,
                dashGapLength: 5,
                lineThickness: 2,
                direction: Axis.vertical,
                lineLength: 35,
              ),
            ),
            Container(
              child: Row(
                children: [
                  // AVATAR IMAGE
                  ClipOval(
                    child: widget.nasabah.profilePhotoPath == null
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: secondaryTextColor,
                                width: 1,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'http://wastebali.com/storage/usersProfile/user.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.nasabah.profilePhotoUrl.toString(),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nasabah',
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        widget.nasabah.name.toString().toUpperCase(),
                        style: secondaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    // KODE PERJALANAN
    Widget perjalananInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          children: [
            Image.asset(
              'assets/icon_perjalanan.png',
              width: 24,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: TextFormField(
                  controller: kodeController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryTextColor,
                      ),
                    ),
                    labelText: "Kode Perjalanan",
                    labelStyle: secondaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                    focusColor: primaryColor,
                    hintText: "Masukkan kode perjalanan",
                    hintStyle: secondaryTextStyle.copyWith(fontSize: 10),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    // TABUNGAN TITLE
    Widget tabunganTitle() {
      return Container(
        child: Text(
          'Tabungan Sampah',
          style: primaryTextStyle.copyWith(
            fontSize: 14,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    // ORGANIK INPUT
    Widget organikInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: CustomTextFormTabungan(
          title: 'Organik',
          hint: 'Jumlah Sampah Organik',
          icon: 'assets/icon_ts_organik.png',
          controller: organikController,
        ),
      );
    }

    // PLASTIK INPUT
    Widget plastikInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: CustomTextFormTabungan(
          title: 'Plastik',
          hint: 'Jumlah Sampah Plastik',
          icon: 'assets/icon_ts_plastik.png',
          controller: plastikController,
        ),
      );
    }

    // KERTAS INPUT
    Widget kertasInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: CustomTextFormTabungan(
          title: 'Kertas',
          hint: 'Jumlah Sampah Kertas',
          icon: 'assets/icon_ts_kertas.png',
          controller: kertasController,
        ),
      );
    }

    // BESI INPUT
    Widget besiInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: CustomTextFormTabungan(
          title: 'Besi',
          hint: 'Jumlah Sampah Besi',
          icon: 'assets/icon_ts_besi.png',
          controller: besiController,
        ),
      );
    }

    // KACA INPUT
    Widget kacaInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: CustomTextFormTabungan(
          title: 'Pecah belah',
          hint: 'Jumlah Sampah Pecah belah',
          icon: 'assets/icon_ts_kaca.png',
          controller: kacaController,
        ),
      );
    }

    // BUTTON SIMPAH
    Widget buttonSimpan() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 50),
        child: CustomButton(
          text: 'Simpan',
          color: primaryColor,
          press: handleSimpan,
        ),
      );
    }

    // BUTTON LOADING
    Widget buttonLoading() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 50),
        child: LoadingButton(),
      );
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Sampah Terpilah',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // perjalananInput(),
              // nasabahInput(),
              header(),
              tabunganTitle(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      organikInput(),
                      plastikInput(),
                      kertasInput(),
                      besiInput(),
                      kacaInput(),
                      isLoading ? buttonLoading() : buttonSimpan(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
