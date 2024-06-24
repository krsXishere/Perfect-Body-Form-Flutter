import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/pages/sign_in_page.dart';
import 'package:perfect_body_form/providers/auth_provider.dart';
import 'package:perfect_body_form/providers/home_provider.dart';
import 'package:perfect_body_form/providers/user_provider.dart';
import 'package:perfect_body_form/widgets/bmi_calculator_widget.dart';
import 'package:perfect_body_form/widgets/bmi_category_widget.dart';
import 'package:perfect_body_form/widgets/custom_button_widget.dart';
import 'package:perfect_body_form/widgets/gap_widget.dart';
import 'package:perfect_body_form/widgets/profile_list_tile_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  showModalUpdateBMI(
    UserProvider userProvider,
    HomeProvider homeProvider,
  ) {
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
              BMICalculatorWidget(
                isUpdate: true,
                isDismissable: false,
                homeProvider: homeProvider,
                userProvider: userProvider,
                heightController: heightController,
                weightController: weightController,
              ),
            ],
          ),
        );
      },
    );
  }

  showModalSignOut(AuthProvider authProvider) {
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
              Center(
                child: Text(
                  "Keluar dari akun?",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
              ),
              const GapWidget(symmetric: "vertical"),
              CustomButtonWidget(
                text: "Keluar",
                color: Colors.red,
                isLoading: authProvider.isLoading,
                onPressed: () {
                  signOut(authProvider);
                },
              ),
              const GapWidget(symmetric: "vertical"),
              CustomButtonWidget(
                text: "Batal",
                color: primaryColor,
                isLoading: false,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  guardedSnackBar(String message) {
    showSnackBar(
      context,
      message,
      Colors.red,
    );
  }

  signOut(AuthProvider authProvider) async {
    if(await authProvider.signOut()) {
      navigate();
    } else {
      guardedSnackBar("Gagal keluar!");
    }
  }

  navigate() {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: const SignInPage(),
        type: PageTransitionType.rightToLeft,
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> getData() async {
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

    return Consumer3<UserProvider, AuthProvider, HomeProvider>(
      builder: (context, userProvider, authProvider, homeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              "Profil Saya",
              style: primaryTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: defaultPadding),
                child: GestureDetector(
                  onTap: () {
                    showModalSignOut(authProvider);
                  },
                  child: Icon(
                    Icons.logout_rounded,
                    color: white,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      boxShadow: [
                        primaryShadow,
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: white,
                          radius: 50,
                          backgroundImage: NetworkImage(
                            "${userProvider.userModel?.profilePhotoURL}&size=100",
                          ),
                        ),
                        const GapWidget(symmetric: "vertical"),
                        Text(
                          userProvider.userModel?.name.toString() ?? "",
                          style: secondaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          userProvider.userModel?.email.toString() ?? "",
                          style: secondaryTextStyle,
                        ),
                        const GapWidget(symmetric: "vertical"),
                        BMICategoryWidget(
                            bmiScore: userProvider.userModel!.bmi?.toDouble() ?? 0.0),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      boxShadow: [
                        primaryShadow,
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileListTileWidget(
                          icon: Icons.male,
                          keyTile: "Jenis kelamin",
                          valueTile: "${userProvider.userModel!.gender}",
                        ),
                        Visibility(
                          visible: userProvider.userModel!.bmi != 0.0,
                          child: Column(
                            children: [
                              ProfileListTileWidget(
                                icon: Icons.height_rounded,
                                keyTile: "Tinggi badan",
                                valueTile: "${userProvider.userModel!.height}",
                              ),
                              ProfileListTileWidget(
                                icon: Icons.monitor_weight_rounded,
                                keyTile: "Berat badan",
                                valueTile: "${userProvider.userModel!.weight}",
                              ),
                              ProfileListTileWidget(
                                icon: Icons.score_rounded,
                                keyTile: "Skor BMI",
                                valueTile: "${userProvider.userModel!.bmi}",
                              ),
                              GestureDetector(
                          onTap: () {
                            showModalUpdateBMI(
                              userProvider,
                              homeProvider,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.edit_note_rounded,
                                color: primaryColor,
                              ),
                              Text(
                                "Perbarui BMI",
                                style: secondaryTextStyle.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const GapWidget(symmetric: "vertical"),
                  Visibility(
                    visible: userProvider.userModel!.bmi == 0.0,
                    child: BMICalculatorWidget(
                      isDismissable: false,
                      homeProvider: homeProvider,
                      userProvider: userProvider,
                      heightController: heightController,
                      weightController: weightController,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
