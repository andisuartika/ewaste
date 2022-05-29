import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme.dart';

class DetailTransaksiItem extends StatelessWidget {
  final String sampah;
  final double jumlah;
  final int harga;
  final double total;

  const DetailTransaksiItem({
    Key? key,
    required this.sampah,
    required this.jumlah,
    required this.harga,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$sampah $jumlah Kg ' +
                  '( ' +
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(harga) +
                  ' )',
              style: secondaryTextStyle.copyWith(
                fontSize: 10,
                fontWeight: regular,
              ),
            ),
          ),
          Text(
            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                .format(total),
            style: secondaryTextStyle.copyWith(
              fontSize: 12,
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }
}
