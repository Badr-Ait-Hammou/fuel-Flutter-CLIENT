import 'package:flutter/material.dart';
import 'package:fuelflutter/pages/Login_Page.dart';
import 'package:fuelflutter/pages/SignUp_Page.dart';
import 'package:fuelflutter/pages/splash_page.dart';

class Routes {
  static const String splashScreen = '/splash';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/signup';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashPage(),
    loginScreen: (context) => LoginPage(),
    signUpScreen: (context) => SignUpPage(),
  };
}
