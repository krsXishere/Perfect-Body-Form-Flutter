import 'package:flutter/material.dart';
import 'package:perfect_body_form/common/constant.dart';

class GapWidget extends StatelessWidget {
  const GapWidget({
    super.key,
    required this.symmetric,
  });

  final String symmetric;

  @override
  Widget build(BuildContext context) {
    return symmetric == "vertical"
        ? SizedBox(height: defaultPadding)
        : SizedBox(width: defaultPadding);
  }
}
