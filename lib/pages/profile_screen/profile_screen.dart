import 'package:flutter/material.dart';
import 'package:fuelflutter/components/app_bar/appbar_image.dart';
import 'package:fuelflutter/components/app_bar/appbar_title.dart';
import 'package:fuelflutter/components/app_bar/custom_app_bar.dart';
import 'package:fuelflutter/components/app_icons.dart';
import 'package:fuelflutter/components/custom_bottom_bar.dart';
import 'package:fuelflutter/components/custom_image_view.dart';
import 'package:fuelflutter/core/utils/size_utils.dart';
import 'package:fuelflutter/pages/dashboard/dashboard_page.dart';
import 'package:fuelflutter/pages/home_page/home_page.dart';
import 'package:fuelflutter/routes.dart';
import 'package:fuelflutter/theme/custom_text_style.dart';
import 'package:fuelflutter/theme/theme_helper.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  bool isSelectedSwitch = false;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        appBar: CustomAppBar(
          leadingWidth: getHorizontalSize(68),
          leading: AppbarImage(
            svgPath: AppIcons.imgGrid,
            margin: getMargin(
              left: 24,
              top: 6,
              bottom: 6,
            ),
          ),
          centerTitle: true,
          title: AppbarTitle(
            text: "Profile",
          ),
        ),
        body: Container(
          width: double.maxFinite,
          padding: getPadding(
            left: 23,
            top: 31,
            right: 23,
            bottom: 31,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: AppIcons.imgEllipse107,
                height: getSize(139),
                width: getSize(139),
                radius: BorderRadius.circular(
                  getHorizontalSize(69),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 2,
                ),
                child: Text(
                  "",
                  style: theme.textTheme.displayMedium,
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 8,
                ),
                child: Text(
                  "",
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 4,
                  top: 32,
                  right: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomImageView(
                      svgPath: AppIcons.imgSettings,
                      height: getSize(20),
                      width: getSize(20),
                      margin: getMargin(
                        top: 5,
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                      ),
                      child: Text(
                        "Password",
                        style: CustomTextStyles.titleLargeSemiBold,
                      ),
                    ),
                    Spacer(),
                    CustomImageView(
                      svgPath: AppIcons.imgArrowright,
                      height: getVerticalSize(14),
                      width: getHorizontalSize(8),
                      margin: getMargin(
                        top: 8,
                        bottom: 3,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 4,
                  top: 32,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomImageView(
                      svgPath: AppIcons.imgFingerprint,
                      height: getVerticalSize(17),
                      width: getHorizontalSize(20),
                      margin: getMargin(
                        top: 7,
                        bottom: 3,
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                      ),
                      child: Text(
                        "Touch ID",
                        style: CustomTextStyles.titleLargeSemiBold,
                      ),
                    ),
                    Spacer(),
                    // CustomSwitch(
                    //   margin: getMargin(
                    //     top: 3,
                    //   ),
                    //   value: isSelectedSwitch,
                    //   onChange: (value) {
                    //     isSelectedSwitch = value;
                    //   },
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 4,
                  top: 33,
                  right: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageView(
                      svgPath: AppIcons.imgCut,
                      height: getSize(20),
                      width: getSize(20),
                      margin: getMargin(
                        top: 2,
                        bottom: 3,
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                      ),
                      child: Text(
                        "Languages",
                        style: CustomTextStyles.titleLargeSemiBold,
                      ),
                    ),
                    Spacer(),
                    CustomImageView(
                      svgPath: AppIcons.imgArrowright,
                      height: getVerticalSize(14),
                      width: getHorizontalSize(8),
                      margin: getMargin(
                        top: 5,
                        bottom: 6,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 4,
                  top: 29,
                  right: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageView(
                      svgPath: AppIcons.imgInfo,
                      height: getSize(20),
                      width: getSize(20),
                      margin: getMargin(
                        top: 3,
                        bottom: 2,
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 16,
                      ),
                      child: Text(
                        "App Information",
                        style: CustomTextStyles.titleLargeSemiBold,
                      ),
                    ),
                    Spacer(),
                    CustomImageView(
                      svgPath: AppIcons.imgArrowright,
                      height: getVerticalSize(14),
                      width: getHorizontalSize(8),
                      margin: getMargin(
                        top: 6,
                        bottom: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
