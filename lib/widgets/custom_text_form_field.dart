import 'package:flutter/material.dart';

import '../theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final String hint;
  final String icon;
  final TextEditingController controller;

  const CustomTextFormField({
    Key? key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: darkGreenTextStyle.copyWith(
            fontSize: 12,
            fontWeight: semiBold,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: backgorundFieldColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: 20,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextFormField(
                    style: primaryTextStyle,
                    controller: controller,
                    decoration: InputDecoration.collapsed(
                      hintText: hint,
                      hintStyle: hintTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: regular,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
