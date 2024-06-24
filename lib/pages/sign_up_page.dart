import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/pages/sign_in_page.dart';
import 'package:perfect_body_form/providers/auth_provider.dart';
import 'package:perfect_body_form/widgets/bottom_navigation_bar_widget.dart';
import 'package:perfect_body_form/widgets/custom_button_widget.dart';
import 'package:perfect_body_form/widgets/custom_question_auth_button_widget.dart';
import 'package:perfect_body_form/widgets/custom_textformfield_widget.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationPasswordController =
      TextEditingController();

  navigate() {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: const BottomNavigationBarWidget(),
        type: PageTransitionType.rightToLeft,
      ),
      (Route<dynamic> route) => false,
    );
  }

  signUp(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmationPasswordController.text.isNotEmpty &&
        authProvider.genderId != null) {
      if (passwordController.text == confirmationPasswordController.text) {
        if (await authProvider.signUp(
          nameController.text,
          emailController.text,
          passwordController.text,
        )) {
          navigate();
        } else {
          if (context.mounted) {
            showSnackBar(
              context,
              authProvider.authModel!.message.toString(),
              Colors.red,
            );
          }
        }
      } else {
        showSnackBar(
          context,
          "Kata sandi tidak cocok",
          Colors.red,
        );
      }
    } else {
      showSnackBar(
        context,
        "Isi semua data",
        Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  SizedBox(
                    height: height(context) * 0.1,
                  ),
                  SvgPicture.asset(
                    "assets/svg/runner-svgrepo-com.svg",
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    "Daftar Untuk Memulai",
                    style: secondaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    "Perfect Body Form",
                    style: secondaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  CustomTextFormField(
                    hintText: "Masukkan nama lengkap",
                    isPasswordField: false,
                    controller: nameController,
                    textInputType: TextInputType.text,
                    onTap: () {},
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  CustomTextFormField(
                    hintText: "Masukkan email",
                    isPasswordField: false,
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    onTap: () {},
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  CustomTextFormField(
                    hintText: "Masukkan kata sandi",
                    isPasswordField: true,
                    isObsecure: authProvider.isObsecure,
                    controller: passwordController,
                    textInputType: TextInputType.text,
                    onTap: () {
                      authProvider.checkObsecure();
                    },
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  CustomTextFormField(
                    hintText: "Konfirmasi kata sandi",
                    isPasswordField: true,
                    isObsecure: authProvider.isObsecureConfirmation,
                    controller: confirmationPasswordController,
                    textInputType: TextInputType.text,
                    onTap: () {
                      authProvider.checkObsecureConfirmation();
                    },
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  DropdownButtonFormField(
                    style: secondaryTextStyle,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(13),
                      fillColor: Colors.grey[300],
                      filled: true,
                      hintText: "Pilih jenis kelamin",
                      hintStyle: primaryTextStyle.copyWith(
                        fontWeight: regular,
                        color: grey400,
                        fontSize: 12,
                      ),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: ["Laki-laki", "Perempuan"]
                        .map(
                          (object) => DropdownMenuItem<String>(
                            value: object,
                            child: Text(
                              object,
                              style: secondaryTextStyle,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      authProvider.checkGender(value);
                    },
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  CustomButtonWidget(
                    text: "Daftar Sekarang!",
                    color: primaryColor,
                    isLoading: authProvider.isLoading,
                    onPressed: () {
                      signUp(
                        context,
                        authProvider,
                      );
                    },
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  const CustomQuestionAuthButtonWidget(
                    question: "Sudah punya akun?",
                    buttonText: "Masuk",
                    page: SignInPage(),
                  ),
                  SizedBox(
                    height: height(context) * 0.1,
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
