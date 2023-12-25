import 'package:flutter/material.dart';
import 'package:fuelflutter/components/app_bar/appbar_image.dart';
import 'package:fuelflutter/components/app_bar/appbar_title.dart';
import 'package:fuelflutter/components/app_bar/custom_app_bar.dart';
import 'package:fuelflutter/components/app_icons.dart';
import 'package:fuelflutter/core/utils/size_utils.dart';
import 'package:fuelflutter/model/chart.dart';
import 'package:fuelflutter/pages/dashboard/components/custom_card.dart';
import 'package:fuelflutter/pages/dashboard/components/pie_chart.dart';
import 'package:fuelflutter/pages/dashboard/components/pie_chart_component.dart';
import 'package:fuelflutter/theme/app_decoration.dart';
import 'package:fuelflutter/theme/custom_text_style.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: getHorizontalSize(68),
        leading: AppbarImage(
          svgPath: AppIcons.imgGrid,
          margin: getMargin(left: 24, top: 6, bottom: 6),
        ),
        title: AppbarTitle(text: "Dashboard", margin: getMargin(left: 23)),
      ),
      body: SafeArea(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            CustomCard(
              title: 'CHART',
              content: PieChartDash(
                dataSource: kChartData,
              ),
            ),
            CustomCard(
              title: 'CHART',
              content: Row(
                children: <Widget>[
                  CategoriesRow(),
                  PieChart(),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.43,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: height * 0.065),
                    const Text(
                      'Monthly Expenses',
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          CategoriesRow(),
                          PieChart(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
