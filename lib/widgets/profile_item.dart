import 'package:flutter/material.dart';

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
            Image.asset(
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
            Image.asset(
              'assets/icon_arrow_right.png',
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
