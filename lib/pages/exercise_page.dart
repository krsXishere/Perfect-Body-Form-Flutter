import 'package:flutter/material.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/providers/exercise_provider.dart';
import 'package:perfect_body_form/providers/home_provider.dart';
import 'package:perfect_body_form/providers/user_provider.dart';
import 'package:perfect_body_form/widgets/bmi_calculator_widget.dart';
import 'package:perfect_body_form/widgets/empty_widget.dart';
import 'package:perfect_body_form/widgets/exercise_card_widget.dart';
import 'package:perfect_body_form/widgets/title_section_widget.dart';
import 'package:provider/provider.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  Future<void> getData() async {
    Provider.of<ExerciseProvider>(
      context,
      listen: false,
    ).getExercises();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      getData();
    });

    return Consumer3<ExerciseProvider, UserProvider, HomeProvider>(
      builder: (context, exerciseProvider, userProvider, homeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              "Menu Latihan",
              style: primaryTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: userProvider.userModel!.bmi != 0.0 &&
                      exerciseProvider.exercises.isNotEmpty
                  ? Column(
                      children: [
                        const TitleSectionWidget(
                          title: "Daftar latihan",
                          subtitle:
                              "Rekomendasi latihan yang cocok dengan masa tubuh kamu",
                        ),
                        ExerciseCardWidget(
                          exerciseProvider: exerciseProvider,
                        ),
                      ],
                    )
                  : exerciseProvider.exercises.isNotEmpty
                      ? Column(
                          children: [
                            const TitleSectionWidget(
                              title: "Kamu belum memenuhi syarat",
                              subtitle:
                                  "Lakukan penghitungan skor BMI di halaman Profil terlebih dahulu",
                            ),
                            BMICalculatorWidget(
                              isDismissable: false,
                              homeProvider: homeProvider,
                              userProvider: userProvider,
                              heightController: heightController,
                              weightController: weightController,
                            ),
                          ],
                        )
                      : const EmptyWidget(
                          title:
                              "Latihan untuk masa tubuh kamu belum tersedia saat ini"),
            ),
          ),
        );
      },
    );
  }
}
