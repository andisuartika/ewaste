import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/article_provider.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/providers/perjalanan_provider.dart';
import 'package:ewaste/providers/sampah_provider.dart';
import 'package:ewaste/providers/slider_provider.dart';
import 'package:ewaste/screens/detail_tugas_perjalanan_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ewaste/screens/webview_screen.dart';
import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/article_item.dart';
import 'package:ewaste/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    ArticleProvider articleProvider = Provider.of<ArticleProvider>(context);
    SampahProvider sampahProvider = Provider.of<SampahProvider>(context);
    SliderProvider sliderProvider = Provider.of<SliderProvider>(context);
    PerjalananProvider perjalananProvider =
        Provider.of<PerjalananProvider>(context);
    RefreshController refreshController = RefreshController();

    // REFRESH
    void _onRefresh() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 10));
      Provider.of<AuthProvider>(context, listen: false).getUser(user.token);
      Provider.of<ArticleProvider>(context, listen: false).getArticles();
      Provider.of<SampahProvider>(context, listen: false).getSampah();
      Provider.of<PerjalananProvider>(context, listen: false).getperjalanan();
      // if failed,use refreshFailed()
      refreshController.refreshCompleted();
    }

    // HEADER
    Widget header() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        height: 85,
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.03),
              spreadRadius: 5,
              blurRadius: 0,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: user.profilePhotoPath == null
                    ? 'http://wastebali.com/storage/usersProfile/user.png'
                    : user.profilePhotoUrl.toString(),
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name.toString(),
                  style: darkGreenTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                Container(
                  width: 180,
                  child: Text(
                    user.alamat == null
                        ? "Silahkan masukkan alamat kamu di profile"
                        : user.alamat.toString(),
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: light,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    // SHOW BOTTOM SHEET INFO
    void showBottomSheet() => showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          context: context,
          builder: (context) => Container(
            height: 150,
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icon_info.svg',
                      width: 24,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Tentang Poin',
                      style: greenTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Point yang berhasil kamu kumpulkan dari hasil menabung sampah dapat kamu tarik melalui bank atau e-wallet yang disediakan E-Waste.',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: regular,
                  ),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        );

    // PETUGAS
    Widget petugas() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(
          right: 30,
          left: 30,
          top: 10,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
        ),
        child: Row(
          children: [
            Image.asset('assets/icon_pengangkutan_sampah.png'),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                perjalananProvider.perjalanan[0].kode.toString(),
                style: whiteTextStyle,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailTugasPerjalananScreen(
                      perjalanan: perjalananProvider.perjalanan.first,
                    ),
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/icon_arrow_right.svg',
                color: whiteColor,
                width: 20,
              ),
            ),
          ],
        ),
      );
    }

    // CONTAINER SALDO
    Widget saldo() {
      return Container(
        width: double.infinity,
        height: 200,
        margin: EdgeInsets.only(
          top: 20,
          right: 30,
          left: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/container_saldo.png'),
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Poin kamu',
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: showBottomSheet,
                    child: SvgPicture.asset('assets/icon_info.svg'),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Consumer<AuthProvider>(
                builder: (context, value, child) => Text(
                  user.points == null
                      ? "Rp0"
                      : NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp',
                          decimalDigits: 0,
                        ).format(
                          authProvider.user.points,
                        ),
                  style: whiteTextStyle.copyWith(
                    fontSize: 30,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                margin: EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/tarik-bank');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: greenTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Tarik',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    // JENIS SAMPAH
    Widget jenisSampah() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: 30,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis Sampah',
              style: darkGreenTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  // ORGANIK
                  sampahProvider.sampah
                      .map(
                        (sampah) => CategoryItem(
                          sampah: sampah,
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      );
    }

    // SLIDER CONTENT
    Widget slider() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                'Event menarik',
                style: darkGreenTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.5,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                items: sliderProvider.sliders.map((i) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white,
                          )),
                      //ClipRRect for image border radius
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: isLoading
                              ? Shimmer.fromColors(
                                  child: Container(
                                    height: 150,
                                    color: Colors.grey.shade300,
                                  ),
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                )
                              : CachedNetworkImage(
                                  imageUrl: i.image.toString(),
                                  height: 150,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    child: Container(
                                      height: 150,
                                    ),
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade300,
                                  ),
                                )
                          // Image.network(
                          //   bannerList![i].image.toString(),
                          //   height: 150,
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                    ),
                    onTap: isLoading
                        ? () {}
                        : () {
                            var url = i.url;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewScreen(
                                  title: 'Event E-Waste',
                                  url: url.toString(),
                                ),
                              ),
                            );

                            print(url.toString());
                          },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }

    // ARTICLE
    Widget article() {
      return Container(
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Artikel yang bisa kamu baca',
                style: darkGreenTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: articleProvider.articles
                  .map(
                    (article) => ArticleItem(article: article),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          header(),
          Expanded(
            child: SmartRefresher(
              controller: refreshController,
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    perjalananProvider.perjalanan.length > 0
                        ? petugas()
                        : SizedBox(),
                    saldo(),
                    jenisSampah(),
                    slider(),
                    article(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
