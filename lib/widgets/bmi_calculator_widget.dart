import 'package:flutter/material.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/providers/home_provider.dart';
import 'package:perfect_body_form/providers/user_provider.dart';
import 'package:perfect_body_form/widgets/custom_button_widget.dart';
import 'package:perfect_body_form/widgets/custom_textformfield_widget.dart';
import 'package:perfect_body_form/widgets/gap_widget.dart';

class BMICalculatorWidget extends StatefulWidget {
  const BMICalculatorWidget({
    super.key,
    required this.homeProvider,
    required this.userProvider,
    required this.heightController,
    required this.weightController,
    this.isDismissable = true,
    this.isOfflineBMICalculator = false,
    this.isUpdate = false,
  });

  final HomeProvider homeProvider;
  final UserProvider userProvider;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final bool isDismissable, isOfflineBMICalculator, isUpdate;

  @override
  State<BMICalculatorWidget> createState() => _BMICalculatorWidgetState();
}

class _BMICalculatorWidgetState extends State<BMICalculatorWidget> {
  Color color = white;
  String category = "";

  bmi(double bmiScore) {
    switch (bmiScore) {
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

  guardedSnackBar(
    String message,
    Color color,
  ) {
    showSnackBar(
      context,
      message,
      color,
    );
  }

  guardedPopNavigator() {
    Navigator.of(context).pop();
  }

  calculateBMI(
    BuildContext context,
    UserProvider userProvider,
    String height,
    String weight,
  ) async {
    if (height.isNotEmpty && weight.isNotEmpty) {
      if (await userProvider.calculateBMI(
        widget.heightController.text,
        widget.weightController.text,
      )) {
        guardedSnackBar(
          userProvider.userModel!.message.toString(),
          Colors.green,
        );

        if (widget.isUpdate) {
          guardedPopNavigator();
        }
      } else {
        guardedSnackBar(
          userProvider.userModel!.message.toString(),
          Colors.red,
        );
      }
    } else {
      showSnackBar(
        context,
        "Isi semua data!",
        Colors.red,
      );
    }
  }

  calculateOfflineBMI(
    HomeProvider homeProvider,
    String height,
    String weight,
  ) {
    if (height.isNotEmpty && weight.isNotEmpty) {
      widget.homeProvider.calculateOfflineBMI(
        widget.heightController.text,
        widget.weightController.text,
      );
    } else {
      showSnackBar(
        context,
        "Isi semua data!",
        Colors.red,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    bmi(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          boxShadow: [
            primaryShadow,
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Hitung berat ideal badanmu di sini",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Visibility(
                visible: widget.isDismissable,
                child: GestureDetector(
                  onTap: () {
                    widget.homeProvider.setDismiss(true);
                  },
                  child: Icon(
                    Icons.cancel_rounded,
                    color: grey400,
                  ),
                ),
              ),
            ],
          ),
          const GapWidget(symmetric: "vertical"),
          CustomTextFormField(
            hintText: "Tinggi badan",
            isPasswordField: false,
            controller: widget.heightController,
            textInputType: TextInputType.number,
            onTap: () {},
          ),
          const GapWidget(symmetric: "vertical"),
          CustomTextFormField(
            hintText: "Berat badan",
            isPasswordField: false,
            controller: widget.weightController,
            textInputType: TextInputType.number,
            onTap: () {},
          ),
          Visibility(
            visible: widget.isOfflineBMICalculator,
            child: Column(
              children: [
                const GapWidget(symmetric: "vertical"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Skor BMI ",
                      style: secondaryTextStyle,
                    ),
                    Text(
                      widget.homeProvider.bmi,
                      style: secondaryTextStyle.copyWith(color: primaryColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 5, horizontal: defaultPadding),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                      ),
                      child: Text(
                        category,
                        style: primaryTextStyle,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const GapWidget(symmetric: "vertical"),
          widget.isOfflineBMICalculator
              ? CustomButtonWidget(
                  text: "Hitung Sekarang!",
                  color: primaryColor,
                  isLoading: widget.homeProvider.isLoading,
                  onPressed: () {
                    calculateOfflineBMI(
                      widget.homeProvider,
                      widget.heightController.text,
                      widget.weightController.text,
                    );
                    bmi(
                      double.parse(widget.homeProvider.bmi),
                    );
                  },
                )
              : CustomButtonWidget(
                  text: "Hitung Sekarang!",
                  color: primaryColor,
                  isLoading: widget.userProvider.isLoading,
                  onPressed: () {
                    calculateBMI(
                      context,
                      widget.userProvider,
                      widget.heightController.text,
                      widget.weightController.text,
                    );
                  },
                ),
        ],
      ),
    );
  }
}
