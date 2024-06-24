import 'package:flutter/material.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/widgets/gap_widget.dart';

class ProfileListTileWidget extends StatelessWidget {
  const ProfileListTileWidget({
    super.key,
    required this.icon,
    required this.keyTile,
    required this.valueTile,
  });

  final IconData icon;
  final String keyTile, valueTile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: grey400,
        ),
        const GapWidget(symmetric: "horizontal"),
        Text(
          "$keyTile: $valueTile",
          style: secondaryTextStyle.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
