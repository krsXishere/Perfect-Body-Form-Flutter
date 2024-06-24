import 'package:flutter/material.dart';
import 'package:perfect_body_form/common/constant.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool isPasswordField;
  final TextEditingController controller;
  final bool isObsecure;
  final TextInputType textInputType;
  final Function() onTap;
  final Color color;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.isPasswordField,
    required this.controller,
    required this.textInputType,
    required this.onTap,
    this.color = const Color.fromARGB(255, 224, 224, 224),
    this.isObsecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return isPasswordField != true
        ? TextFormField(
            controller: controller,
            style: secondaryTextStyle,
            keyboardType: textInputType,
            decoration: InputDecoration(
              fillColor: color,
              filled: true,
              hintText: hintText,
              hintStyle: primaryTextStyle.copyWith(
                fontWeight: regular,
                color: grey400,
                fontSize: 12,
              ),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          )
        : TextFormField(
            controller: controller,
            style: secondaryTextStyle,
            keyboardType: textInputType,
            obscureText: isObsecure,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: onTap,
                child: Icon(
                  isObsecure ? Icons.visibility_off : Icons.visibility,
                  color: isObsecure ? grey500 : primaryColor,
                ),
              ),
              fillColor: color,
              filled: true,
              hintText: hintText,
              hintStyle: primaryTextStyle.copyWith(
                fontWeight: regular,
                color: grey400,
                fontSize: 12,
              ),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          );
  }
}
