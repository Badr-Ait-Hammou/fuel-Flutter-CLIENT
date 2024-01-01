import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuelflutter/components/app_icons.dart';
import 'package:fuelflutter/pages/home_container_screen/home_container_screen.dart';
import 'package:fuelflutter/routes.dart';
import 'package:fuelflutter/service/auth.server.dart';
import '../components/custom_elevated_button.dart';
import '../components/custom_image_view.dart';
import '../components/custom_outlined_button.dart';
import '../components/custom_text_form_field.dart';
import '../core/utils/size_utils.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';
import 'Login_Page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordVerify = TextEditingController();
  final TextEditingController nom = TextEditingController();
  final TextEditingController prenom = TextEditingController();
  bool isVisible = true;
  bool isVisibleConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appTheme.gray50,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Form(
                child: Container(
                    width: double.maxFinite,
                    padding:
                        getPadding(left: 27, top: 80, right: 27, bottom: 40),
                    child: Column(
                       // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          CustomImageView(
                            svgPath: AppIcons.slpashIcon,
                            height: getSize(80),
                            width: getSize(80),
                            alignment: Alignment.center,
                          ),
                          Padding(
                              padding: getPadding(top: 30),
                              child: Text("Fuel Pulse",
                                  style: CustomTextStyles.displayMediumBold)),
                          Padding(
                              padding: getPadding(top: 3),
                              child: Text("Welcome To Fuel Pulse",
                                  style: theme.textTheme.bodyLarge)),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                        Padding(
                                            padding: getPadding(top: 36),
                                            child: Text(" FirstName",
                                                style: CustomTextStyles.bodyLargeGray700)),
                                    CustomTextFormField(
                                      controller: prenom,
                                      margin: getMargin(top: 5),
                                      hintText: "FirstName",
                                      hintStyle:
                                          CustomTextStyles.bodyLargeGray70018,
                                      textInputType: TextInputType.emailAddress,
                                      prefix: Container(
                                        margin: getMargin(
                                            left: 25,
                                            top: 24,
                                            right: 10,
                                            bottom: 24),
                                        child: CustomImageView(
                                            svgPath: AppIcons.imgNavprofile),
                                      ),
                                      prefixConstraints: BoxConstraints(
                                          maxHeight: getVerticalSize(72)),
                                      contentPadding: getPadding(
                                          top: 24, right: 30, bottom: 24),
                                      borderDecoration: TextFormFieldStyleHelper
                                          .outlinePrimaryContainer,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: getPadding(top: 36),
                                      child: Text("LastName",
                                          style: CustomTextStyles
                                              .bodyLargeGray700),
                                    ),
                                    CustomTextFormField(
                                      controller: nom,
                                      margin: getMargin(top: 5),
                                      hintText: "LastName",
                                      hintStyle:
                                          CustomTextStyles.bodyLargeGray70018,
                                      textInputType: TextInputType.emailAddress,
                                      prefix: Container(
                                        margin: getMargin(
                                            left: 25,
                                            top: 24,
                                            right: 10,
                                            bottom: 24),
                                        child: CustomImageView(
                                            svgPath: AppIcons.imgNavprofile),
                                      ),
                                      prefixConstraints: BoxConstraints(
                                          maxHeight: getVerticalSize(72)),
                                      contentPadding: getPadding(
                                          top: 24, right: 30, bottom: 24),
                                      borderDecoration: TextFormFieldStyleHelper
                                          .outlinePrimaryContainer,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(top: 5),
                                  child: Text(" Email",
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
                                  svgPath: AppIcons.imgArrowdown),
                            ),
                            prefixConstraints:
                                BoxConstraints(maxHeight: getVerticalSize(72)),
                            contentPadding:
                                getPadding(top: 24, right: 30, bottom: 24),
                            borderDecoration: TextFormFieldStyleHelper
                                .outlinePrimaryContainer,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(top: 5),
                                  child: Text(" Set Password",
                                      style: CustomTextStyles.bodyLargeGray700))),
                          CustomTextFormField(
                              controller: password,
                              margin: getMargin(top: 9),
                              hintText: "Set Password",
                              hintStyle: CustomTextStyles.bodyLargeGray70018,
                              textInputType: TextInputType.visiblePassword,
                              prefix: Container(
                                  margin: getMargin(
                                      left: 25, top: 24, right: 10, bottom: 24),
                                  child: CustomImageView(
                                      svgPath: AppIcons.imgLock)),
                              prefixConstraints: BoxConstraints(
                                  maxHeight: getVerticalSize(72)),
                              suffix: IconButton(
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                              ),
                              obscureText: isVisible,
                              contentPadding:
                                  getPadding(top: 24, right: 30, bottom: 24),
                              borderDecoration: TextFormFieldStyleHelper
                                  .outlinePrimaryContainer),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(top: 5),
                                  child: Text(" Confirm Password",
                                      style: CustomTextStyles.bodyLargeGray700))),
                          CustomTextFormField(
                              controller: passwordVerify,
                              margin: getMargin(top: 9),
                              hintText: "Confirm Password",
                              hintStyle: CustomTextStyles.bodyLargeGray70018,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              prefix: Container(
                                  margin: getMargin(
                                      left: 28, top: 24, right: 10, bottom: 24),
                                  child: CustomImageView(
                                      svgPath: AppIcons.imgLock)),
                              prefixConstraints: BoxConstraints(
                                  maxHeight: getVerticalSize(72)),
                              suffix: IconButton(
                                icon: Icon(
                                  isVisibleConfirm
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isVisibleConfirm = !isVisibleConfirm;
                                  });
                                },
                              ),
                              obscureText: isVisibleConfirm,
                              contentPadding:
                                  getPadding(top: 24, right: 30, bottom: 24),
                              borderDecoration: TextFormFieldStyleHelper
                                  .outlinePrimaryContainer),
                          CustomElevatedButton(
                            height: getVerticalSize(72),
                            text: "Sign Up",
                            margin: getMargin(top: 20),
                            buttonTextStyle:
                                CustomTextStyles.titleMediumOnPrimarySemiBold18,
                            buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                            ),
                            onTap: () async {
                              await onTapTxtSignUp(context);
                            },
                          ),
                          CustomOutlinedButton(
                              text: "Sign up with Google",
                              margin: getMargin(top: 10),
                              leftIcon: Container(
                                  margin: getMargin(right: 16),
                                  child: CustomImageView(
                                      svgPath: AppIcons.imgGoogle))),
                          Align(
                              alignment: Alignment.center,
                              child: Padding(
                                  padding: getPadding(top: 20, bottom: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: getPadding(bottom: 2),
                                            child: Text("You Have Account?",
                                                style: CustomTextStyles
                                                    .titleLargeBluegray700)),
                                        GestureDetector(
                                            onTap: () {
                                              onTapTxtSignin(context);
                                            },
                                            child: Padding(
                                                padding:
                                                    getPadding(left: 8),
                                                child: Text("Sign in",
                                                    style: CustomTextStyles
                                                        .titleLargePrimary)))
                                      ])))
                        ])))));
  }

  onTapTxtSignin(BuildContext context) {
    Navigator.pushNamed(context, Routes.loginScreen);
  }

  onTapTxtSignUp(BuildContext context) async {
    if (email.text.isEmpty ||
        password.text.isEmpty ||
        nom.text.isEmpty ||
        prenom.text.isEmpty) {
      showCustomToast("Veuillez remplir tous les champs", Colors.orangeAccent);
      return;
    }
    try {
      final response = await Authentification()
          .register(email.text, password.text, nom.text, prenom.text);
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeContainerScreen()),
        );
      } else {
        showCustomToast("Register error", Colors.red);
      }
    } catch (e) {
      print('Error during Register: $e');
      showCustomToast("An error occurred during Register", Colors.red);
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
