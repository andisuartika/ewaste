import 'package:flutter/material.dart';

import '../theme.dart';

class ArticleItem extends StatelessWidget {
  final String img;
  final String title;
  final String desc;
  const ArticleItem(
      {Key? key, required this.img, this.title = '', this.desc = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kerajinan unik dari barang bekas.',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: Text(
                      'Beberapa kerajinan ini bisa kamu buat dirumah dengan mudah, yuk dicoba dengan bahan yang mudah kamu temui dirumah dan pastinya berguna banget buat kamu',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: light,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Baca selengkapnya..',
                      style: greenTextStyle.copyWith(
                        fontSize: 8,
                        fontWeight: light,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            height: 90,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(img),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
