import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuelflutter/components/app_icons.dart';
import 'package:fuelflutter/components/custom_image_view.dart';
import 'package:fuelflutter/core/utils/size_utils.dart';
import 'package:fuelflutter/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      await init();
    });
    super.initState();
  }

  Future<void> init() async {
    Navigator.pushNamed(context, Routes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: SizedBox(
          width: double.maxFinite,
          child: CustomImageView(
            svgPath: AppIcons.slpashIcon,
            height: getVerticalSize(108),
            width: getHorizontalSize(106),
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
