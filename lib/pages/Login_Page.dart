import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fuelflutter/routes.dart';

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
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   height: 400,
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('images/back1.png'),
//                           fit: BoxFit.cover)),
//                   child: Stack(
//                     children: <Widget>[
//                       Positioned(
//                         left: 30,
//                         width: 80,
//                         height: 200,
//                         child: FadeInUp(
//                             duration: Duration(seconds: 1),
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                   image: DecorationImage(
//                                       image: AssetImage('images/light-1.png'))),
//                             )),
//                       ),
//                       Positioned(
//                         left: 140,
//                         width: 80,
//                         height: 150,
//                         child: FadeInUp(
//                             duration: Duration(milliseconds: 1200),
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                   image: DecorationImage(
//                                       image: AssetImage('images/light-2.png'))),
//                             )),
//                       ),
//                       Positioned(
//                         right: 40,
//                         top: 40,
//                         width: 80,
//                         height: 150,
//                         child: FadeInUp(
//                             duration: Duration(milliseconds: 1300),
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                   image: DecorationImage(
//                                       image: AssetImage('images/clock.png'))),
//                             )),
//                       ),
//                       Positioned(
//                         child: FadeInUp(
//                             duration: Duration(milliseconds: 1600),
//                             child: Container(
//                               margin: EdgeInsets.only(top: 50),
//                               child: const Center(
//                                 child: Text(
//                                   "Login",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 40,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             )),
//                       )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.all(30.0),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: <Widget>[
//                           FadeInUp(
//                               duration: Duration(milliseconds: 1800),
//                               child: Container(
//                                 padding: EdgeInsets.all(5),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                         color: const Color.fromRGBO(
//                                             11, 77, 84, 1.0)),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           color:
//                                               Color.fromRGBO(143, 148, 251, .2),
//                                           blurRadius: 20.0,
//                                           offset: Offset(0, 10))
//                                     ]),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Container(
//                                       padding: EdgeInsets.all(8.0),
//                                       decoration: const BoxDecoration(
//                                           border: Border(
//                                               bottom: BorderSide(
//                                                   color: Color.fromRGBO(
//                                                       24, 157, 131, 1.0)))),
//                                       child: TextField(
//                                         controller: _email,
//                                         decoration: InputDecoration(
//                                             border: InputBorder.none,
//                                             hintText: "Email",
//                                             hintStyle: TextStyle(
//                                                 color: Colors.grey[700])),
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: TextField(
//                                         controller: _password,
//                                         obscureText: true,
//                                         decoration: InputDecoration(
//                                             border: InputBorder.none,
//                                             hintText: "Password",
//                                             hintStyle: TextStyle(
//                                                 color: Colors.grey[700])),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               )),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           FadeInUp(
//                             duration: Duration(milliseconds: 1900),
//                             child: Container(
//                               height: 50,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   gradient: const LinearGradient(colors: [
//                                     Color.fromRGBO(11, 77, 84, 1.0),
//                                     Color.fromRGBO(24, 157, 131, 1.0),
//                                   ])),
//                               child: Center(
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     // if (_formKey.currentState!.validate()) {
//                                     //   signInWithEmailAndPassword();
//                                     // }
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.transparent,
//                                     elevation: 0,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   child: const Text(
//                                     "Login",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 70,
//                           ),
//                           FadeInUp(
//                             duration: Duration(milliseconds: 2000),
//                             child: GestureDetector(
//                               onTap: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SignUpPage()),
//                               ),
//                               child: const Text(
//                                 "Sign Up",
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: Color.fromRGBO(11, 77, 84, 1.0)),
//                               ),
//                             ),
//                             // child: const Text("Sign up ?",
//                             // style: TextStyle(
//                             //     color: Color.fromRGBO(143, 148, 251, 1)),)),
//                           )
//                         ],
//                       ),
//                     ))
//               ],
//             ),
//           ),
//         ));
//   }
// }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return  Scaffold(
        backgroundColor: appTheme.gray100,
        resizeToAvoidBottomInset: false,
        body: Form(
            key: _formKey,
            child: Container(
                width: double.maxFinite,
                padding:
                getPadding(left: 27, top: 40, right: 27, bottom: 40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                          svgPath: AppIcons.slpashIcon,
                          height: getSize(80),
                          width: getSize(80)),
                      Padding(
                          padding: getPadding(top: 55),
                          child: Text("Hello!",
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
                                  style:
                                  CustomTextStyles.bodyLargeGray700))),
                      CustomTextFormField(
                          //controller: phoneController,
                          margin: getMargin(top: 5),
                          hintText: "Email",
                          hintStyle: CustomTextStyles.bodyLargeGray70018,
                          textInputType: TextInputType.emailAddress,
                          prefix: Container(
                              margin: getMargin(
                                  left: 25, top: 24, right: 10, bottom: 24),
                              child: CustomImageView(
                                  svgPath: AppIcons.imgArrowdown)),
                          prefixConstraints: BoxConstraints(
                              maxHeight: getVerticalSize(72)),
                          contentPadding:
                          getPadding(top: 24, right: 30, bottom: 24),
                          borderDecoration: TextFormFieldStyleHelper
                              .outlinePrimaryContainer),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(top: 25),
                              child: Text("Password",
                                  style:
                                  CustomTextStyles.bodyLargeGray700))),
                      CustomTextFormField(
                          //controller: passwordController,
                          margin: getMargin(top: 5),
                          hintText: "Password",
                          hintStyle: CustomTextStyles.bodyLargeGray70018,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          prefix: Container(
                              margin: getMargin(
                                  left: 25, top: 24, right: 10, bottom: 24),
                              child: CustomImageView(
                                  svgPath: AppIcons.imgLock)),
                          prefixConstraints: BoxConstraints(
                              maxHeight: getVerticalSize(72)),
                          obscureText: true,
                          contentPadding:
                          getPadding(top: 24, right: 30, bottom: 24),
                          borderDecoration: TextFormFieldStyleHelper
                              .outlinePrimaryContainer),
                      CustomElevatedButton(
                        height: getVerticalSize(72),
                        text: "Sign In",
                        margin: getMargin(top: 40),
                        buttonTextStyle: CustomTextStyles.titleMediumOnPrimarySemiBold18,
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[300],
                        ),
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
                                        padding:
                                        getPadding(left: 8, top: 2),
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
}

