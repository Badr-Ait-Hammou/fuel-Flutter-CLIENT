import 'package:flutter/material.dart';
import 'package:fuelflutter/pages/Login_Page.dart';
import 'package:fuelflutter/pages/SignUp_Page.dart';
import 'package:fuelflutter/pages/dashboard/dashboard_page.dart';
import 'package:fuelflutter/pages/home_container_screen/home_container_screen.dart';
import 'package:fuelflutter/pages/profile_screen/profile_screen.dart';
import 'package:fuelflutter/pages/splash_page.dart';

class Routes {
  static const String splashScreen = '/splash';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/signup';
  static const String dashboard = '/dashboard';
  static const String homeScreen = '/home';
  static const String profileScreen = '/profile';
  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashPage(),
    loginScreen: (context) => LoginPage(),
    signUpScreen: (context) => SignUpPage(),
    dashboard: (context) => DashboardPage(),
    homeScreen: (context) => HomeContainerScreen(),
    profileScreen: (context) => ProfilePage()
  };
}
