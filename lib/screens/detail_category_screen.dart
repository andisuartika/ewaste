import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';

class DetailCategoryScreen extends StatefulWidget {
  const DetailCategoryScreen({Key? key}) : super(key: key);

  @override
  State<DetailCategoryScreen> createState() => _DetailCategoryScreenState();
}

class _DetailCategoryScreenState extends State<DetailCategoryScreen> {
  List images = [
    'https://images.unsplash.com/photo-1536700626482-f7d798222061?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
    'https://images.unsplash.com/photo-1523293915678-d126868e96f1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1553787434-45e1d245bfbb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjV8fHdhc3RlJTIwb3JnYW5pY3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // DOT INDICATOR
    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 16 : 4,
        height: 4,
        margin: EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? primaryColor : Color(0xffC4C4C4),
        ),
      );
    }

    // HEADER
    Widget header() {
      int index = -1;

      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: images
                .map(
                  (index) => Image.network(
                    index,
                    width: MediaQuery.of(context).size.width,
                    height: 310,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          ),
        ],
      );
    }

    Widget content() {
      int index = -1;

      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: whiteColor,
        ),
        child: Column(
          children: [
            // NOTE: HEADER
            Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sampah organik',
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // NOTE: PRICE
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 20,
                left: defaultMargin,
                right: defaultMargin,
              ),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryDarkColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Harga /kg',
                    style: whiteTextStyle,
                  ),
                  Text(
                    'Rp.500,00',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),

            // NOTE: DESCRIPTION
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tentang Sampah',
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Sampah organik merupakan sampah ramah lingkungan dan dapat diolah kembali menjadi sesuatu yang bermanfaat bila dikelola dengan benar. tetapi jika tidak dikelola dengan baik dan benar maka akan menimbulkan bau yang kurang sedang dan dapat menimbulkan penyakit dari hasil pembusukan sampah organik yang cepat.',
                    style: secondaryTextStyle.copyWith(
                      fontWeight: light,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
