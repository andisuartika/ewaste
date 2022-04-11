import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ewaste/models/nasabah_model.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/custom_text_form_tabungan.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class SampahCampuranScreen extends StatefulWidget {
  final NasabahModel nasabah;
  const SampahCampuranScreen({Key? key, required this.nasabah})
      : super(key: key);

  @override
  _SampahCampuranScreenState createState() => _SampahCampuranScreenState();
}

class _SampahCampuranScreenState extends State<SampahCampuranScreen> {
  final _formKey = GlobalKey<FormState>();

  List<String> nasabah = [
    'Andi Suartika',
    'Kadek Wibawa',
    'Putu Purnama',
    'Nyoman Wenten',
    'Ketut Ardika',
    'Melsi Oktaviani'
  ];

  TextEditingController kodeController = TextEditingController(text: '');
  TextEditingController nasabahController = TextEditingController(text: '');
  TextEditingController campuranController = TextEditingController(text: '');

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
      Navigator.pushNamed(context, '/konfirmasi-sampah');

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

    // NASABAH
    Widget nasabahInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          children: [
            Image.asset(
              'assets/icon_nasabah.png',
              width: 24,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: nasabahController,
                    decoration: InputDecoration(
                      labelText: 'Nasabah',
                      labelStyle: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                      hintText: "Masukkan Nasabah",
                      hintStyle: secondaryTextStyle.copyWith(
                        fontSize: 10,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) => nasabah.where(
                    (item) => item.toLowerCase().contains(
                          pattern.toLowerCase(),
                        ),
                  ),
                  itemBuilder: (context, String item) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.asset(
                            'assets/icon_profile_default.png',
                            width: 35,
                          ),
                        ),
                        title: Text(
                          item,
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: semiBold,
                          ),
                        ),
                        subtitle: Text(
                          'Jalan Pratu Praupan Sukasada Pratu Praupan Sukasada',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: light,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                  noItemsFoundBuilder: (context) => Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 5,
                      ),
                      child: Center(
                        child: Text(
                          'Nasabah tidak ditemukan',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: semiBold,
                          ),
                        ),
                      )),
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (String value) {
                    nasabahController.text = value;
                  },
                ),
              ),
            )
          ],
        ),
      );
    }

    // SAMPAH TITLE
    Widget sampahTitle() {
      return Container(
        child: Text(
          'Sampah',
          style: primaryTextStyle.copyWith(
            fontSize: 14,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    // SAMPAH INPUT
    Widget sampahInput() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: CustomTextFormTabungan(
          title: 'Sampah',
          hint: 'Jumlah Sampah',
          icon: 'assets/icon_ts_campuran.png',
          controller: campuranController,
        ),
      );
    }

    // BUTTON SIMPAH
    Widget buttonSimpan() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 30),
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
        margin: EdgeInsets.symmetric(vertical: 30),
        child: LoadingButton(),
      );
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Sampah Campuran',
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // perjalananInput(),
                // nasabahInput(),
                header(),
                sampahTitle(),
                sampahInput(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: isLoading ? buttonLoading() : buttonSimpan(),
      ),
    );
  }
}
