import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuelflutter/pages/home_container_screen/home_container_screen.dart';
import 'package:fuelflutter/pages/home_page/home_page.dart';
import 'package:fuelflutter/routes.dart';
import 'package:fuelflutter/service/auth.server.dart';
import '../components/app_icons.dart';
import '../components/custom_elevated_button.dart';
import '../components/custom_image_view.dart';
import '../components/custom_outlined_button.dart';
import '../components/custom_text_form_field.dart';
import '../core/utils/size_utils.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';
import 'SignUp_Page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginEcranState();
}

class _LoginEcranState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: appTheme.gray50,
        resizeToAvoidBottomInset: false,
        body: Form(
            key: formKey,
            child: Container(
                width: double.maxFinite,
                padding: getPadding(left: 27, top: 80, right: 27, bottom: 40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                          svgPath: AppIcons.slpashIcon,
                          height: getSize(80),
                          width: getSize(80)),
                      Padding(
                          padding: getPadding(top: 55),
                          child: Text("Fuel Pulse",
                              style: CustomTextStyles.displayMediumBold)),
                      Padding(
                          padding: getPadding(top: 3),
                          child: Text("Enter Your Detail Below",
                              style: theme.textTheme.bodyLarge)),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(top: 36),
                              child: Text("Phone or Email",
                                  style: CustomTextStyles.bodyLargeGray700))),
                      CustomTextFormField(
                          controller: email,
                          margin: getMargin(top: 5),
                          hintText: "Email",
                          hintStyle: CustomTextStyles.bodyLargeGray70018,
                          textInputType: TextInputType.emailAddress,
                          prefix: Container(
                              margin: getMargin(
                                  left: 25, top: 24, right: 10, bottom: 24),
                              child: CustomImageView(
                                  svgPath: AppIcons.imgArrowdown)),
                          prefixConstraints:
                              BoxConstraints(maxHeight: getVerticalSize(72)),
                          contentPadding:
                              getPadding(top: 24, right: 30, bottom: 24),
                          borderDecoration:
                              TextFormFieldStyleHelper.outlinePrimaryContainer),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(top: 25),
                              child: Text("Password",
                                  style: CustomTextStyles.bodyLargeGray700))),
                      CustomTextFormField(
                          controller: password,
                          margin: getMargin(top: 5),
                          hintText: "Password",
                          hintStyle: CustomTextStyles.bodyLargeGray70018,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          prefix: Container(
                              margin: getMargin(
                                  left: 25, top: 24, right: 10, bottom: 24),
                              child:
                                  CustomImageView(svgPath: AppIcons.imgLock)),
                          prefixConstraints:
                              BoxConstraints(maxHeight: getVerticalSize(72)),
                          obscureText: true,
                          contentPadding:
                              getPadding(top: 24, right: 30, bottom: 24),
                          borderDecoration:
                              TextFormFieldStyleHelper.outlinePrimaryContainer),
                      CustomElevatedButton(
                        height: getVerticalSize(72),
                        text: "Sign In",
                        margin: getMargin(top: 40),
                        buttonTextStyle:
                            CustomTextStyles.titleMediumOnPrimarySemiBold18,
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                        ),
                        onTap: () {
                          onTapTxtSignIn(context);
                        },
                      ),
                      CustomOutlinedButton(
                          text: "Sign in with Google",
                          margin: getMargin(top: 40),
                          leftIcon: Container(
                              margin: getMargin(right: 18),
                              child: CustomImageView(
                                  svgPath: AppIcons.imgGoogle))),
                      Padding(
                          padding: getPadding(top: 34, bottom: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: getPadding(bottom: 2),
                                    child: Text("Have Account?",
                                        style: CustomTextStyles
                                            .titleLargeBluegray700)),
                                GestureDetector(
                                    onTap: () {
                                      onTapTxtSignup(context);
                                    },
                                    child: Padding(
                                        padding: getPadding(left: 8, top: 2),
                                        child: Text("Sign up",
                                            style: CustomTextStyles
                                                .titleLargePrimary)))
                              ]))
                    ]))));
  }

  /// Navigates to the signUpScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [Navigator] widget
  /// to push the named route for the signUpScreen.
  onTapTxtSignup(BuildContext context) {
    Navigator.pushNamed(context, Routes.signUpScreen);
  }

  onTapTxtSignIn(BuildContext context) async {
    try {
      final response =
          await Authentification().login(email.text, password.text);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeContainerScreen()),
        );
      } else {
        showCustomToast("Login error", Colors.red);
      }
    } catch (e) {
      print('Error during login: $e');
      showCustomToast("An error occurred during login", Colors.red);
    }
  }

  void showCustomToast(String message, Color colors) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: colors,
      textColor: Colors.black,
      fontSize: 16.0,
      webShowClose: true,
      webPosition: "center",
    );
  }
}
