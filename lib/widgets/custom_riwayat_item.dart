import 'package:ewaste/models/transaksi_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class CustomRiwayatItem extends StatefulWidget {
  final TransaksiModel transaksi;
  const CustomRiwayatItem({
    Key? key,
    required this.transaksi,
  }) : super(key: key);

  @override
  State<CustomRiwayatItem> createState() => _CustomRiwayatItemState();
}

class _CustomRiwayatItemState extends State<CustomRiwayatItem> {
  bool isTabungan = true;
  String icon = '';
  String title = '';
  Color? color;

  @override
  void initState() {
    if (widget.transaksi.jenisTransaksi == "TRANSAKSI MASUK") {
      setState(() {
        title = "Menabung Sampah";
        icon = "assets/icon_riwayat_tabungan.png";
        color = primaryColor;
      });
    } else if (widget.transaksi.jenisTransaksi == "TRANSAKSI POINT") {
      setState(() {
        title = "Tarik Tabungan";
        icon = "assets/icon_riwayat_tarik.png";
        color = redTextColor;
      });
    } else if (widget.transaksi.jenisTransaksi == "TRANSAKSI IURANS") {
      setState(() {
        title = "Iuran Sampah";
        icon = "assets/icon_riwayat_iuran.png";
        color = redTextColor;
      });
    } else if (widget.transaksi.jenisTransaksi ==
        "TRANSAKSI PEMBAYARAN IURAN") {
      setState(() {
        title = "Pembarayan Iuran Sampah";
        icon = "assets/icon_riwayat_iuran.png";
        color = redTextColor;
      });
    }
    super.initState();
  }

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
                      image: AssetImage(icon),
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
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.transaksi.date.toString().substring(0, 10) +
                            ' | ' +
                            widget.transaksi.date.toString().substring(11, 16),
                        style: primaryTextStyle.copyWith(
                          fontSize: 8,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp',
                    decimalDigits: 0,
                  ).format(
                    widget.transaksi.total!,
                  ),
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
