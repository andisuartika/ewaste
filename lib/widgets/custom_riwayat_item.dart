import 'package:flutter/material.dart';

import '../theme.dart';

class CustomRiwayatItem extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final Color color;
  final int nominal;

  const CustomRiwayatItem({
    Key? key,
    required this.image,
    required this.title,
    required this.date,
    required this.nominal,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 5),
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(image),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: darkGreenTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        date,
                        style: primaryTextStyle.copyWith(
                          fontSize: 8,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '+ $nominal Points',
                  style: greenTextStyle.copyWith(
                    color: color,
                    fontWeight: semiBold,
                    fontSize: 16,
                  ),
                ),
              ],
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
      ),
    );
  }
}
