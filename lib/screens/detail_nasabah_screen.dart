import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/screens/home/input_sampah_screen.dart';
import 'package:ewaste/services/transaksi_service.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class DetailNasabahScreen extends StatefulWidget {
  final UserModel nasabah;
  const DetailNasabahScreen({Key? key, required this.nasabah})
      : super(key: key);

  @override
  State<DetailNasabahScreen> createState() => _DetailNasabahScreenState();
}

class _DetailNasabahScreenState extends State<DetailNasabahScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Detail Nasabah',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/main'),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: 30,
                    left: 30,
                    top: 100,
                  ),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 70,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.nasabah.name.toString(),
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.nasabah.noHp.toString(),
                          style: secondaryTextStyle,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.nasabah.alamat.toString(),
                          style: secondaryTextStyle,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        CustomButton(
                          text: 'Lanjutkan',
                          color: primaryColor,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    InputSampahScreen(nasabah: widget.nasabah),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 20,
                    child: widget.nasabah.profilePhotoPath == null
                        ? Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: secondaryTextColor,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    'http://wastebali.com/storage/usersProfile/user.png'),
                              ),
                            ),
                          )
                        : Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: secondaryTextColor,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  widget.nasabah.profilePhotoUrl.toString(),
                                ),
                              ),
                            ),
                          )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
