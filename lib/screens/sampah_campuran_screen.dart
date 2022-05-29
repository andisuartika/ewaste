import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/screens/konfirmasi_iuran_sampah_screen.dart';
import 'package:ewaste/services/sampah_service.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:ewaste/widgets/custom_text_form_tabungan.dart';
import 'package:ewaste/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class SampahCampuranScreen extends StatefulWidget {
  final UserModel nasabah;
  const SampahCampuranScreen({Key? key, required this.nasabah})
      : super(key: key);

  @override
  _SampahCampuranScreenState createState() => _SampahCampuranScreenState();
}

class _SampahCampuranScreenState extends State<SampahCampuranScreen> {
  final _formKey = GlobalKey<FormState>();
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

      double kuantitas = double.parse(campuranController.text);
      var _sampah = await SampahService().getSampahCampuran();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KonfirmasiIuranSampahScreen(
            sampah: _sampah,
            nasabah: widget.nasabah,
            kuantitas: kuantitas,
          ),
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
