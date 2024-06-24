import 'package:flutter/material.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/widgets/gap_widget.dart';

class TitleSectionWidget extends StatelessWidget {
  const TitleSectionWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                title,
                style: secondaryTextStyle.copyWith(
                  fontWeight: bold,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                subtitle,
                style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                  color: grey400,
                ),
              ),
            ),
          ],
        ),
        const GapWidget(symmetric: "vertical"),
      ],
    );
  }
}
