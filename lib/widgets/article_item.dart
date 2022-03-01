import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewaste/models/article_model.dart';
import 'package:ewaste/screens/webview_screen.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class ArticleItem extends StatelessWidget {
  final ArticleModel article;
  const ArticleItem({
    Key? key,
    required this.article,
  }) : super(key: key);

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
                    article.title.toString(),
                    style: primaryTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: medium,
                      height: 1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: Text(
                      article.desc.toString(),
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: light,
                        height: 1.2,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      // textAlign: TextAlign.justify,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewScreen(
                            title: article.title.toString(),
                            url: article.url.toString(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Baca selengkapnya..',
                      style: greenTextStyle.copyWith(
                        fontSize: 10,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: article.image.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
