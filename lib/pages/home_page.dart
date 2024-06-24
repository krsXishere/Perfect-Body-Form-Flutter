import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/providers/home_provider.dart';
import 'package:perfect_body_form/providers/user_provider.dart';
import 'package:perfect_body_form/widgets/bmi_calculator_widget.dart';
import 'package:perfect_body_form/widgets/gap_widget.dart';
import 'package:perfect_body_form/widgets/title_section_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  getData() {
    Provider.of<UserProvider>(
      context,
      listen: false,
    ).getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });

    return Consumer2<HomeProvider, UserProvider>(
      builder: (context, homeProvider, userProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Row(
              children: [
                Text(
                  "Hai, ",
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  cuttedName(userProvider.userModel?.name ?? " "),
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: defaultPadding),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    "${userProvider.userModel?.profilePhotoURL}&size=128",
                  ),
                  onBackgroundImageError: (exception, stackTrace) {},
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const GapWidget(symmetric: "vertical"),
                  Visibility(
                    visible: homeProvider.isDismiss == false &&
                        userProvider.userModel?.bmi == 0,
                    child: Column(
                      children: [
                        BMICalculatorWidget(
                          homeProvider: homeProvider,
                          userProvider: userProvider,
                          heightController: heightController,
                          weightController: weightController,
                        ),
                        const GapWidget(symmetric: "vertical"),
                      ],
                    ),
                  ),
                  const TitleSectionWidget(
                      title: "Latih tubuhmu demi tubuh yang sehat!",
                      subtitle:
                          "Model di bawah ini sangat konsisten olahraga!!!"),
                  FlutterCarousel(
                    items: carouselModelImages(),
                    options: CarouselOptions(
                      showIndicator: false,
                      floatingIndicator: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      pauseAutoPlayOnTouch: true,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                    ),
                  ),
                  const GapWidget(symmetric: "vertical"),
                  const TitleSectionWidget(
                    title: "Kalkulator BMI",
                    subtitle:
                        "Gunakan kalkulator di bawah ini untuk menghitung BMI dengan akurat",
                  ),
                  BMICalculatorWidget(
                    isDismissable: false,
                    isOfflineBMICalculator: true,
                    homeProvider: homeProvider,
                    userProvider: userProvider,
                    heightController: heightController,
                    weightController: weightController,
                  ),
                  SizedBox(
                    height: height(context) * 0.1,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> carouselModelImages() {
    return [
      modelImageTemplate("2"),
      modelImageTemplate("3"),
      modelImageTemplate("4_p"),
      modelImageTemplate("6_p"),
      modelImageTemplate("7"),
      modelImageTemplate("w_1"),
      modelImageTemplate("w_2"),
      modelImageTemplate("w_3"),
    ];
  }

  Widget modelImageTemplate(String fileName) {
    return Container(
      height: height(context) * 0.3,
      width: width(context) * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        child: Image.asset(
          "assets/png/$fileName.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
