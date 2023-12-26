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
import 'components/fl_pie_chart.dart';
import 'components/fl_pie_chart2.dart';
import 'components/linear_chart.dart';

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
            const CustomCard(
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
                    const Expanded(
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
            CustomCard(
              title: 'Monthly Expenses',
              content: SizedBox(
                height: height * 0.55,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: height *0.0001),
                      const Text(
                        'Monthly Expenses',
                      ),
                      const Expanded(
                        child: AspectRatio(
                          aspectRatio: 20 / 9,
                          child: LineChartSample1(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ), CustomCard(
              title: 'Monthly Expenses',
              content: SizedBox(
                height: height * 0.55,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: height *0.0001),
                      const Text(
                        'Monthly Expenses',
                      ),
                      const Expanded(
                        child: AspectRatio(
                          aspectRatio: 20 / 9,
                          child: PieChartSample3(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomCard(
              title: 'Monthly Expenses',
              content: SizedBox(
                height: height * 0.55,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: height *0.0001),
                      const Text(
                        'Monthly Expenses',
                      ),
                      const Expanded(
                        child: AspectRatio(
                          aspectRatio: 20 / 9,
                          child: PieChartSample2(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
