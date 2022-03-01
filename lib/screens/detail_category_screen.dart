import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:shimmer/shimmer.dart';

import '../theme.dart';

class DetailCategoryScreen extends StatefulWidget {
  const DetailCategoryScreen({Key? key}) : super(key: key);

  @override
  State<DetailCategoryScreen> createState() => _DetailCategoryScreenState();
}

class _DetailCategoryScreenState extends State<DetailCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // HEADER
    Widget header() {
      return Stack(
        children: [
          Stack(
            children: [
              Container(
                child: CachedNetworkImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1536703219213-0223580c76b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1471&q=80",
                  placeholder: (context, url) => Shimmer.fromColors(
                    child: Container(
                      height: height * 0.36,
                      width: double.infinity,
                    ),
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade300,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  height: height * 0.4,
                ),
              ),
              // Image.network(
              //   'https://images.unsplash.com/photo-1536703219213-0223580c76b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1471&q=80',
              //   height: height * 0.4,
              //   fit: BoxFit.cover,
              // ),
              Positioned(
                top: height * 0.36,
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 30,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 35,
                height: 35,
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: whiteColor,
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }

    // CONTENT
    Widget content() {
      return Container(
        margin: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TITLE SAMPAH
            Text(
              'Sampah Organik',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),

            // HARGA
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                    'Rp. 500,00',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    // ARTICLE
    Widget article() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          children: [
            // TENTANG SAMPAH
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tentang Sampah',
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Sampah organik merupakan sampah ramah lingkungan dan dapat diolah kembali menjadi sesuatu yang bermanfaat bila dikelola dengan benar. tetapi jika tidak dikelola dengan baik dan benar maka akan menimbulkan bau yang kurang sedang dan dapat menimbulkan penyakit dari hasil pembusukan sampah organik yang cepat.',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: light,
                    ),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),

            // PENGELOLAAN SAMPAH
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 15,
                bottom: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pengelolaan Sampah',
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Sampah organik merupakan bisa dimanfaatkan kembali menjadi pupuk kompos yang dilakukan secara alami. Pembuatan pupuk kompos mudah dan dapat berguna untuk budidaya tanaman.',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: light,
                    ),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          header(),
          content(),
          Expanded(
            child: SingleChildScrollView(
              child: article(),
            ),
          ),
        ],
      ),
    );
  }
}
