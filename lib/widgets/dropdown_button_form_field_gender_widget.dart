import 'package:flutter/material.dart';
import 'package:perfect_body_form/common/constant.dart';

class DropdownButtonFormFieldGenderWidget extends StatelessWidget {
  const DropdownButtonFormFieldGenderWidget({
    super.key,
    required this.onChanged,
  });

  final void Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      style: secondaryTextStyle,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(13),
        fillColor: Colors.grey[300],
        filled: true,
        hintText: "Pilih jenis kelamin",
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
      items: ["Laki-laki", "Perempuan"]
          .map(
            (object) => DropdownMenuItem<String>(
              value: object,
              child: Text(
                object,
                style: secondaryTextStyle,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
