import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewaste/models/sampah_model.dart';
import 'package:ewaste/providers/sampah_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../theme.dart';

class DetailCategoryScreen extends StatefulWidget {
  final SampahModel sampah;
  const DetailCategoryScreen({
    Key? key,
    required this.sampah,
  }) : super(key: key);

  @override
  State<DetailCategoryScreen> createState() => _DetailCategoryScreenState();
}

class _DetailCategoryScreenState extends State<DetailCategoryScreen> {
  @override
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
                  imageUrl: widget.sampah.image.toString(),
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
              widget.sampah.nama.toString(),
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
                    'Rp. ${widget.sampah.harga}',
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
                    widget.sampah.tentang.toString(),
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
                    widget.sampah.pengelolaan.toString(),
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
