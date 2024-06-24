import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/pages/sign_up_page.dart';
import 'package:perfect_body_form/providers/auth_provider.dart';
import 'package:perfect_body_form/widgets/bottom_navigation_bar_widget.dart';
import 'package:perfect_body_form/widgets/custom_button_widget.dart';
import 'package:perfect_body_form/widgets/custom_question_auth_button_widget.dart';
import 'package:perfect_body_form/widgets/custom_textformfield_widget.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  guardedSnackBar(String message) {
    showSnackBar(
      context,
      message,
      Colors.red,
    );
  }

  signIn(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      if (await authProvider.signIn(
        emailController.text,
        passwordController.text,
      )) {
        navigate();
      } else {
        guardedSnackBar(authProvider.authModel!.message.toString());
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
                    "Masuk Untuk Memulai",
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
                  CustomButtonWidget(
                    text: "Masuk Sekarang!",
                    color: primaryColor,
                    isLoading: authProvider.isLoading,
                    onPressed: () {
                      signIn(
                        context,
                        authProvider,
                      );
                    },
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  const CustomQuestionAuthButtonWidget(
                    question: "Belum punya akun?",
                    buttonText: "Daftar",
                    page: SignUpPage(),
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
