import 'package:flutter/material.dart';

import '../theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function() press;

  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
