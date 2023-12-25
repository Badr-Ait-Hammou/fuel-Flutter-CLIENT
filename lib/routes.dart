import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fuelflutter/pages/Login_Page.dart';
import 'package:fuelflutter/pages/SignUp_Page.dart';
import 'package:fuelflutter/pages/bar_Chart.dart';
import 'package:fuelflutter/pages/chart.dart';
import 'package:fuelflutter/pages/splash_page.dart';

class Routes {
  static const String splashScreen = '/splash';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/signup';
  static const String chartScreen = '/chart';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashPage(),
    loginScreen: (context) => LoginPage(),
    signUpScreen: (context) => SignUpPage(),
    chartScreen: (context) => LineChartSample2(),
    // chartScreen: (context) => BarChartSample3(),
  };
}
