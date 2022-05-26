import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/bank_provider.dart';
import 'package:ewaste/screens/tarik/tarik_konfirmasi_screen.dart';
import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TarikBankScreen extends StatefulWidget {
  const TarikBankScreen({Key? key}) : super(key: key);

  @override
  State<TarikBankScreen> createState() => _TarikBankScreenState();
}

class _TarikBankScreenState extends State<TarikBankScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<BankProvider>(context, listen: false).getBanks();
    super.initState();
  }

  int bankSelected = 0;
  String bankName = '';

  bool isBank = false;
  bool isLoading = false;
  bool errorBank = false;
  int saldo = 250000;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    final formkey = GlobalKey<FormState>();
    BankProvider bankProvider = Provider.of<BankProvider>(context);
    TextEditingController noRekController = TextEditingController(text: '');
    TextEditingController nameController = TextEditingController(text: '');
    TextEditingController nominalController = TextEditingController(text: '');

    // HANDLE REKENING
    handleRekening() async {
      setState(() {
        isLoading = true;
      });

      print('data terkirim');
      print('id bank : $bankSelected');
      print('nomor rek : ${noRekController.text}');
      print('nama : ${nameController.text}');
      print('nominal : ${nominalController.text}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TarikKonfirmasiScreen(
            idBank: bankSelected,
            bankName: bankName,
            norek: noRekController.text,
            name: nameController.text,
            nominal: int.parse(nominalController.text),
          ),
        ),
      );
      // setState(() {
      //   isLoading = false;
      // });
    }

    // DAFTAR BANK
    Widget daftarBank() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Bank',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 120,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      // VALID BANK SELECTED
                      errorBank = false;

                      // SELECTED BANK
                      bankSelected = bankProvider.banks[index].id!;
                      bankName = bankProvider.banks[index].name!;

                      // SELECT BANK OR EWALLET081
                      if (bankProvider.banks[index].type == 'BANK') {
                        isBank = true;
                      } else {
                        isBank = false;
                      }

                      print('Bank Selected : $bankSelected');
                      print('Is Bank : $isBank');
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      border: bankSelected == bankProvider.banks[index].id!
                          ? Border.all(
                              width: 2,
                              color: primaryColor,
                            )
                          : Border.all(
                              color: secondaryTextColor,
                            ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: bankProvider.banks[index].image.toString(),
                    ),
                  ),
                ),
                itemCount: bankProvider.banks.length,
              ),
            ),
            errorBank
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Silahkan pilih Bank tujuan',
                      style: primaryTextStyle.copyWith(
                        fontSize: 12,
                        color: redTextColor,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      );
    }

    // FORM REKENING
    Widget formRekening() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: noRekController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  // NULL
                  if (value!.isEmpty) {
                    return isBank
                        ? 'Masukkan Nomor Rekening'
                        : 'Masukkan Nomor Handphone';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: secondaryTextColor,
                    ),
                  ),
                  labelText: isBank ? 'Nomor Rekening' : 'Nomor Handphone',
                  labelStyle: secondaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                  focusColor: primaryColor,
                  hintText: isBank
                      ? 'Masukkan Nomor Rekening'
                      : 'Masukkan Nomor Handphone',
                  hintStyle: secondaryTextStyle.copyWith(fontSize: 10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  // NULL
                  if (value!.isEmpty) {
                    return 'Masukkan Nama';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: secondaryTextColor,
                    ),
                  ),
                  labelText: 'Nama',
                  labelStyle: secondaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                  focusColor: primaryColor,
                  hintText: 'Masukkan Nama',
                  hintStyle: secondaryTextStyle.copyWith(fontSize: 10),
                ),
              ),
            )
          ],
        ),
      );
    }

    // POINT EWASTE
    Widget pointEwaste() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Poin Kamu',
            style: secondaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 60,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: secondaryTextColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/ewaste.png',
                  width: 35,
                  height: 35,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Poin E-aste',
                        style: primaryTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                    Text(
                      user.points == null
                          ? 'Rp0'
                          : NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp',
                              decimalDigits: 0,
                            ).format(int.parse(user.points!)),
                      style: greenTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      );
    }

    // JUMLAH TARIK
    Widget nominal() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: defaultMargin),
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgorundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah Tarik',
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            ),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: nominalController,
                validator: (value) {
                  // NULL
                  if (value!.isEmpty) {
                    return 'Masukkan Nominal';
                  }
                  // MINIMAL TRANSAKSI 50.000
                  if (int.parse(value) < 50000) {
                    return 'Minimal Rp50.000';
                  }
                  // POINT TIDAK CUKUP
                  if (int.parse(value) + 2500 >= int.parse(user.points!)) {
                    return 'Poin anda tidak cukup *biaya admin Rp2.500';
                  }
                  return null;
                },
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
                  border: InputBorder.none,
                  focusColor: primaryColor,
                  prefixText: 'Rp',
                  hintText: '0',
                  hintStyle: secondaryTextStyle.copyWith(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // BUTTON REGISTER
    Widget buttonLoading() {
      return Container(
        child: LoadingButton(),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Masukkan Rekening',
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
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                daftarBank(),
                formRekening(),
                pointEwaste(),
                nominal(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: isLoading
            ? LoadingButton()
            : CustomButton(
                text: 'Lanjutkan',
                color: primaryColor,
                press: () {
                  if (bankSelected != 0) {
                    if (formkey.currentState!.validate()) {
                      handleRekening();
                    }
                  } else {
                    setState(() {
                      errorBank = true;
                    });
                  }
                },
              ),
      ),
    );
  }
}
