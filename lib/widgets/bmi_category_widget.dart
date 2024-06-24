import 'package:flutter/material.dart';
import 'package:perfect_body_form/common/constant.dart';

class BMICategoryWidget extends StatefulWidget {
  const BMICategoryWidget({
    super.key,
    required this.bmiScore,
  });

  final double bmiScore;

  @override
  State<BMICategoryWidget> createState() => _BMICategoryWidgetState();
}

class _BMICategoryWidgetState extends State<BMICategoryWidget> {
  Color color = white;
  String category = "";

  bmi() {
    switch (widget.bmiScore) {
      case 0.0:
        color = Colors.red;
        category = "Belum dihitung";
        break;
      case < 18.5:
        color = Colors.red;
        category = "Underweigth";
        break;
      case > 18.5 && < 24.9:
        color = primaryColor;
        category = "Ideal";
        break;
      case > 25 && < 29.9:
        color = Colors.yellow;
        category = "Overweight";
        break;
      case > 30:
        color = Colors.red;
        category = "Obesity";
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    bmi();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: defaultPadding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Text(
        category,
        style: primaryTextStyle,
      ),
    );
  }
}
