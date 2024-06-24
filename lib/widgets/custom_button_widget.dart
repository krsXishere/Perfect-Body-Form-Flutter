import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/constant.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final bool isLoading;
  final Function() onPressed;
  final Color color;
  final bool isEnable;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.color,
    required this.isLoading,
    this.isEnable = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          backgroundColor: isEnable == true ? color : grey400,
        ),
        onPressed: isEnable == true ? onPressed : () {},
        child: isLoading == true
            ? CupertinoActivityIndicator(
                color: white,
              )
            : Text(
                text,
                style: primaryTextStyle,
              ),
      ),
    );
  }
}
