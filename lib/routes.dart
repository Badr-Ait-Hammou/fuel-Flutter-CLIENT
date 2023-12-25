import 'package:flutter/material.dart';
import 'package:fuelflutter/pages/splash_page.dart';

class Routes {
  static const String splashScreen = '/splash';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashPage()
  };
}
