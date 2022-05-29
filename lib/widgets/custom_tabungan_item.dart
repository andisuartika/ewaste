import 'package:flutter/material.dart';

import '../theme.dart';

class CustomTabunganItem extends StatelessWidget {
  final int icon;
  final String sampah;
  final String kuantitas;
  const CustomTabunganItem(
      {Key? key,
      required this.icon,
      required this.sampah,
      required this.kuantitas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List icons = [
      'assets/icon_js_organik.png',
      'assets/icon_js_plastik.png',
      'assets/icon_js_kertas.png',
      'assets/icon_js_besi.png',
      'assets/icon_js_kaca.png',
    ];

    return Container(
      width: double.infinity,
      height: 65,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: backgorundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(icons[icon]),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              sampah,
              style: greenTextStyle.copyWith(
                fontSize: 14,
                fontWeight: medium,
              ),
            ),
          ),
          Text(
            '$kuantitas Kg',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
