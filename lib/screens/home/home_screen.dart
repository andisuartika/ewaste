import 'package:carousel_slider/carousel_slider.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/screens/detail_category_screen.dart';
import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/article_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    final List<String> bannerList = [
      'assets/content_slider_1.png',
      'assets/content_slider_1.png',
      'assets/content_slider_1.png',
    ];

    final List<String> articleList = [
      'https://images.unsplash.com/photo-1525695230005-efd074980869?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      'https://images.unsplash.com/photo-1533629046790-addefc28951e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'https://images.unsplash.com/photo-1528323273322-d81458248d40?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1229&q=80',
      'https://images.unsplash.com/photo-1611284446314-60a58ac0deb9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    ];

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
          top: 30,
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
          top: 30,
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
          top: 30,
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
            SizedBox(
              height: 15,
            ),
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  // height: 145,
                  aspectRatio: 2.5,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                items: bannerList
                    .map(
                      (item) => Container(
                        child: Center(
                          child: Image.asset(item, fit: BoxFit.cover),
                        ),
                      ),
                    )
                    .toList(),
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
              children: [
                ArticleItem(img: articleList[0]),
                ArticleItem(img: articleList[1]),
                ArticleItem(img: articleList[2]),
                ArticleItem(img: articleList[3]),
              ],
            )
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
