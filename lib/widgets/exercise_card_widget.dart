import 'package:flutter/material.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/providers/detail_achievement_provider.dart';
import 'package:perfect_body_form/providers/exercise_provider.dart';

class ExerciseCardWidget extends StatefulWidget {
  const ExerciseCardWidget({
    super.key,
    required this.exerciseProvider,
    required this.detailAchievementProvider,
  });

  final ExerciseProvider exerciseProvider;
  final DetailAchievementProvider detailAchievementProvider;

  @override
  State<ExerciseCardWidget> createState() => _ExerciseCardWidgetState();
}

class _ExerciseCardWidgetState extends State<ExerciseCardWidget> {
  navigatePop() {
    Navigator.of(context).pop();
  }

  showModal(
    ExerciseProvider exerciseProvider,
    int index,
    bool isButtonActive,
    String exerciseId,
  ) {
    // print("$isButtonActive");
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(defaultPadding),
          height: height(context) * 0.5,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(defaultBorderRadius),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: defaultPadding),
                  height: 10,
                  width: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: isButtonActive
                        ? () async {
                            if (await widget.detailAchievementProvider
                                .createAchievement(exerciseId)) {
                              widget.detailAchievementProvider.getAchievement();
                              widget.detailAchievementProvider.getDetailAchievements();
                              navigatePop();
                            }
                          }
                        : null,
                    child: Row(
                      children: [
                        Text(
                          isButtonActive ? "Selesaikan" : "Selesai",
                          style: primaryTextStyle.copyWith(
                              color: isButtonActive ? primaryColor : grey400),
                        ),
                        Icon(
                          Icons.check,
                          color: isButtonActive ? primaryColor : grey400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                widget.exerciseProvider.exercises[index].exerciseName
                    .toString(),
                style: secondaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    "${widget.exerciseProvider.exercises[index].setType} "
                        .toString(),
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.exerciseProvider.exercises[index].time.toString(),
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Text(
                "Instruksi:",
                style: secondaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                  color: primaryColor,
                ),
              ),
              Text(
                widget.exerciseProvider.exercises[index].instructions
                    .toString(),
                style: secondaryTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        // mainAxisExtent: 160,
      ),
      itemCount: widget.exerciseProvider.exercises.length,
      itemBuilder: (context, index) {
        final exercise = widget.exerciseProvider.exercises[index];
        bool isButtonActive = widget
            .detailAchievementProvider.detailAchievementModels
            .any((achievement) =>
                achievement.exerciseId == exercise.id && achievement.status!);

        return GestureDetector(
          onTap: () {
            showModal(
              widget.exerciseProvider,
              index,
              !isButtonActive,
              exercise.id.toString(),
            );
          },
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            height: 100,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              border: Border.all(
                color: !isButtonActive ? primaryColor : Colors.transparent,
              ),
              boxShadow: [
                primaryShadow,
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    widget.exerciseProvider.exercises[index].exerciseName
                        .toString(),
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${widget.exerciseProvider.exercises[index].setType} "
                          .toString(),
                      style: secondaryTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget.exerciseProvider.exercises[index].time
                            .toString(),
                        style: secondaryTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Instruksi:",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  widget.exerciseProvider.exercises[index].instructions
                      .toString(),
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
