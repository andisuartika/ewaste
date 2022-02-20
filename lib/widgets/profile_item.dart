import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';

class ProfileItem extends StatelessWidget {
  final String icon;
  final String title;
  final Function() press;

  const ProfileItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                title,
                style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: regular,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icon_arrow_right.svg',
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
