import 'package:ewaste/providers/notification_provider.dart';
import 'package:ewaste/widgets/custom_pesan_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';

class PesanScreen extends StatefulWidget {
  const PesanScreen({Key? key}) : super(key: key);

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> {
  @override
  Widget build(BuildContext context) {
    NotificationProvider notificationProvider =
        Provider.of<NotificationProvider>(context);
    // HEADER
    Widget header() {
      return AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Notifikasi',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    // RIWAYAT CONTENT
    Widget pesan() {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(
            right: 30,
            left: 30,
            bottom: 30,
            top: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: notificationProvider.notification
                  .map((notification) => CustomPesanItem(
                        notification: notification,
                      ))
                  .toList(),
            ),
          ),
        ),
      );
    }

    // PESAN EMPTY
    Widget empty() {
      return Expanded(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image_empty_pesan.png',
                width: 80,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Yahh, Belum ada pesan nih...',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        notificationProvider.notification.length > 0 ? pesan() : empty(),
      ],
    );
  }
}
