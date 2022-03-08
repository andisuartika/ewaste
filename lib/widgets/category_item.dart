import 'package:ewaste/models/sampah_model.dart';
import 'package:ewaste/screens/detail_category_screen.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class CategoryItem extends StatelessWidget {
  final SampahModel sampah;
  const CategoryItem({Key? key, required this.sampah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List icons = [
      'assets/icon_js_organik.png',
      'assets/icon_js_plastik.png',
      'assets/icon_js_kertas.png',
      'assets/icon_js_besi.png',
      'assets/icon_js_kaca.png',
    ];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailCategoryScreen(
            sampah: sampah,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(right: sampah.id! < 3 ? 5 : 0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(icons[sampah.id! - 1]),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              sampah.nama.toString(),
              style: secondaryTextStyle.copyWith(
                fontSize: 10,
                fontWeight: light,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
