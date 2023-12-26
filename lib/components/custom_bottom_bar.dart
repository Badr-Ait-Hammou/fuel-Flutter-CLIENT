import 'package:flutter/material.dart';
import 'package:fuelflutter/components/app_icons.dart';
import 'package:fuelflutter/components/custom_image_view.dart';
import 'package:fuelflutter/core/utils/size_utils.dart';
import 'package:fuelflutter/theme/custom_text_style.dart';
import 'package:fuelflutter/theme/theme_helper.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({super.key, this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: AppIcons.imgHome,
      activeIcon: AppIcons.imgHome,
      title: "Home",
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: AppIcons.imgNavactivity,
      activeIcon: AppIcons.imgNavactivity,
      title: "Dashboard",
      type: BottomBarEnum.Dashboard,
    ),
    BottomMenuModel(
      icon: AppIcons.imgNavprofile,
      activeIcon: AppIcons.imgNavprofile,
      title: "Profile",
      type: BottomBarEnum.Profile,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getVerticalSize(60),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageView(
                  svgPath: bottomMenuList[index].icon,
                  height: getSize(24),
                  width: getSize(24),
                  color: appTheme.gray500,
                ),
                Text(
                  bottomMenuList[index].title ?? "",
                  style: CustomTextStyles.bodySmallGray50001.copyWith(
                    color: appTheme.gray50001,
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageView(
                  svgPath: bottomMenuList[index].activeIcon,
                  height: getSize(24),
                  width: getSize(24),
                  color: appTheme.gray10001,
                ),
                Text(
                  bottomMenuList[index].title ?? "",
                  style: CustomTextStyles.bodySmallOnPrimary.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Dashboard,
  Profile,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
