import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final String hint;
  final String icon;
  final validator;
  final keyboardType;
  final TextEditingController controller;

  const CustomTextFormField({
    Key? key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.validator,
    this.keyboardType,
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
          width: double.infinity,
          child: TextFormField(
            cursorColor: primaryTextColor,
            keyboardType: keyboardType,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
              hintText: hint,
              hintStyle: hintTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
              fillColor: backgorundFieldColor,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              prefixIcon: SvgPicture.asset(
                icon,
                width: 10,
                height: 10,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
