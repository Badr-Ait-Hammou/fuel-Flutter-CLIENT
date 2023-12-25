import 'package:flutter/material.dart';
import 'package:fuelflutter/components/app_bar/appbar_image.dart';
import 'package:fuelflutter/components/app_bar/appbar_title.dart';
import 'package:fuelflutter/components/app_bar/custom_app_bar.dart';
import 'package:fuelflutter/components/app_icons.dart';
import 'package:fuelflutter/core/utils/size_utils.dart';
import 'package:fuelflutter/theme/app_decoration.dart';
import 'package:fuelflutter/theme/custom_text_style.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            leadingWidth: getHorizontalSize(68),
            leading: AppbarImage(
                svgPath: AppIcons.imgGrid,
                margin: getMargin(left: 24, top: 6, bottom: 6)),
            title: AppbarTitle(text: "Dashboard", margin: getMargin(left: 23))),
        body: Container(
            width: double.maxFinite,
            padding: getPadding(left: 24, top: 34, right: 24, bottom: 34),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  width: getHorizontalSize(360),
                  margin: getMargin(right: 6),
                  padding: getPadding(left: 90, top: 17, right: 90, bottom: 17),
                  decoration: AppDecoration.fillPrimary,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Total Balance",
                            style: CustomTextStyles.bodyLargeGray10001),
                        Text("3,567.12",
                            style: CustomTextStyles.displayMediumGray10001)
                      ])),
              Expanded(
                  child: Padding(
                      padding: getPadding(left: 3, top: 50, right: 3),
                      child: Text('dash')))
            ])));
  }
}
