import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';

class CustomTextFormTabungan extends StatelessWidget {
  final String title;
  final String hint;
  final String icon;
  final TextEditingController controller;

  const CustomTextFormTabungan({
    Key? key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 24,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: secondaryTextColor,
                  ),
                ),
                labelText: title,
                labelStyle: secondaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
                focusColor: primaryColor,
                hintText: hint,
                hintStyle: secondaryTextStyle.copyWith(fontSize: 10),
                suffixText: "Kg",
                suffixStyle: secondaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
