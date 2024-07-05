import 'package:flutter/material.dart';
import 'package:perfect_body_form/common/constant.dart';

class AchievementProgressBarWidget extends StatelessWidget {
  const AchievementProgressBarWidget({
    super.key,
    required this.value,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      height: 100,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(defaultBorderRadius),
        ),
        border: Border.symmetric(
          horizontal: BorderSide(
            color: grey300,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Capaian kamu hari ini",
            style: secondaryTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width(context) * 0.7,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  backgroundColor: grey300,
                  value: value / 100,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
              Text(
                "$value%",
                style: primaryTextStyle.copyWith(
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
