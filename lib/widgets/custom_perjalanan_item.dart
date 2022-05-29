import 'package:ewaste/models/perjalanan_model.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class CustomPerjalananItem extends StatelessWidget {
  final PerjalananModel perjalanan;
  const CustomPerjalananItem({Key? key, required this.perjalanan})
      : super(key: key);

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
                      image: AssetImage('assets/icon_pengangkutan_sampah.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        perjalanan.kode.toString(),
                        style: darkGreenTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        perjalanan.keterangan.toString(),
                        style: primaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: light,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        perjalanan.waktuTugas.toString(),
                        style: primaryTextStyle.copyWith(
                          fontSize: 8,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  perjalanan.status.toString(),
                  style: greenTextStyle.copyWith(
                    color: primaryColor,
                    fontWeight: semiBold,
                    fontSize: 12,
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
