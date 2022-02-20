import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/custom_text_form_tabungan.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../theme.dart';

class SampahTerpilahScreen extends StatefulWidget {
  const SampahTerpilahScreen({Key? key}) : super(key: key);

  @override
  State<SampahTerpilahScreen> createState() => _SampahTerpilahScreenState();
}

class _SampahTerpilahScreenState extends State<SampahTerpilahScreen> {
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
  TextEditingController organikController = TextEditingController(text: '');
  TextEditingController plastikController = TextEditingController(text: '');
  TextEditingController kertasController = TextEditingController(text: '');
  TextEditingController besiController = TextEditingController(text: '');
  TextEditingController kacaController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // HANDLE SAVE
    handleSimpan() async {
      setState(() {
        isLoading = true;
      });

      Navigator.pushNamed(context, '/konfirmasi-tabungan');

      setState(() {
        isLoading = false;
      });
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

    // TABUNGAN TITLE
    Widget tabunganTitle() {
      return Container(
        margin: EdgeInsets.only(top: 50),
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
          icon: 'assets/icon_ts_organik.svg',
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
          icon: 'assets/icon_ts_plastik.svg',
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
          icon: 'assets/icon_ts_kertas.svg',
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
          icon: 'assets/icon_ts_besi.svg',
          controller: organikController,
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
          icon: 'assets/icon_ts_kaca.svg',
          controller: organikController,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                perjalananInput(),
                nasabahInput(),
                tabunganTitle(),
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
      ),
    );
  }
}
