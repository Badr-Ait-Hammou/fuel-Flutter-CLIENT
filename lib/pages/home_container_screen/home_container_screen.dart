import 'package:flutter/material.dart';
import 'package:fuelflutter/components/custom_bottom_bar.dart';
import 'package:fuelflutter/core/utils/size_utils.dart';
import 'package:fuelflutter/main.dart';
import 'package:fuelflutter/pages/dashboard/dashboard_page.dart';
import 'package:fuelflutter/pages/home_page/home_page.dart';
import 'package:fuelflutter/pages/profile_screen/profile_screen.dart';
import 'package:fuelflutter/routes.dart';
import 'package:fuelflutter/theme/theme_helper.dart';

// ignore_for_file: must_be_immutable
class HomeContainerScreen extends StatelessWidget {
  const HomeContainerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: Navigator(
          key: appNavigatorKey,
          initialRoute: Routes.homeScreen,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: const Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(
          onChanged: (BottomBarEnum type) {
            Navigator.pushNamed(
                appNavigatorKey.currentContext!, getCurrentRoute(type));
          },
        ),
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return Routes.homeScreen;
      case BottomBarEnum.Activity:
        return Routes.dashboard;
      case BottomBarEnum.Profile:
        return Routes.profileScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case Routes.homeScreen:
        return HomePage();
      case Routes.dashboard:
        return DashboardPage();
      case Routes.profileScreen:
        return ProfilePage();
      default:
        return DefaultWidget();
    }
  }
}
