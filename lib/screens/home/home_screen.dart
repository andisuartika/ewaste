import 'package:carousel_slider/carousel_slider.dart';
import 'package:ewaste/faker/slider_faker.dart';
import 'package:ewaste/models/slider_model.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/article_provider.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/screens/detail_category_screen.dart';
import 'package:ewaste/screens/webview_screen.dart';
import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/article_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SliderModel>? bannerList;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      bannerList = slidersFaker;
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    ArticleProvider articleProvider = Provider.of<ArticleProvider>(context);

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
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(user.profilePhotoUrl.toString()),
                ),
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
              Text(
                user.points == null ? "0" : user.points.toString(),
                style: whiteTextStyle.copyWith(
                  fontSize: 30,
                  fontWeight: semiBold,
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                margin: EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () {},
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
          right: 30,
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
              children: [
                // ORGANIK
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailCategoryScreen(),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/icon_js_organik.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Oragnik',
                        style: secondaryTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
                // PLASTIK
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/icon_js_plastik.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Plastik',
                        style: secondaryTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
                // KERTAS
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/icon_js_kertas.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Kertas',
                        style: secondaryTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
                // BESI
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/icon_js_besi.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Besi',
                        style: secondaryTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
                // KACA
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/icon_js_kaca.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Kaca',
                        style: secondaryTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
              child: CarouselSlider.builder(
                itemCount: bannerList!.length,
                options: CarouselOptions(
                  aspectRatio: 2.5,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                itemBuilder: (context, i, id) {
                  //for onTap to redirect to another screen
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
                        child: Image.network(
                          bannerList![i].image.toString(),
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: () {
                      var url = bannerList![i].url;
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
                },
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
                'Info yang bisa kamu baca',
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  saldo(),
                  jenisSampah(),
                  slider(),
                  article(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
