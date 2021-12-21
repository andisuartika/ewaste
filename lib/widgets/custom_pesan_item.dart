import 'package:flutter/material.dart';

import '../theme.dart';

class CustomPesanItem extends StatelessWidget {
  final String date;
  final String pesan;

  const CustomPesanItem({
    Key? key,
    required this.date,
    required this.pesan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      margin: EdgeInsets.only(
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: primaryTextStyle.copyWith(
              fontSize: 8,
              fontWeight: light,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            child: Text(
              pesan,
              style: darkGreenTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 1,
            color: secondaryTextColor,
          ),
        ],
      ),
    );
  }
}
