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
import '../../components/custom_icon_button.dart';
import '../../components/custom_image_view.dart';
import '../../model/operation.model.dart';
import '../../service/dashboard.service.dart';
import '../../theme/app_decoration.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import 'components/fl_pie_chart2.dart';
import 'components/linear_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  List<TransactionData> _transactions = [];

  @override
  void initState() {
    super.initState();
    // Call the method to fetch transactions when the widget is initialized
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    try {
      final transactions = await DashboardService().getUserTransactions();
      setState(() {
        _transactions = transactions;
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appTheme.gray100,
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
                      SizedBox(height: height * 0.0001),
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
                      SizedBox(height: height * 0.0001),
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
            ),CustomCard(
              title: 'My Custom Card Title',
              content: SizedBox(
                height: height * 0.55,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: height * 0.0001),
                      const Text(
                        'My Expenses',
                      ),
                       Expanded(
                        child: Padding(
                          padding: getPadding(
                            left: 2,
                            top: 2,
                            right: 2,
                          ),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (
                                context,
                                index,
                                ) {
                              return SizedBox(
                                height: getVerticalSize(20),
                              );
                            },

                            itemCount: _transactions.length,
                            itemBuilder: (context, index) {
                              TransactionData transaction = _transactions[index];
                              return Container(
                                padding: getPadding(
                                  left: 10,
                                  top: 10,
                                  right: 10,
                                  bottom: 10,
                                ),
                                decoration: AppDecoration.white,
                                child: Row(
                                  children: [
                                    CustomIconButton(
                                      height: getSize(56),
                                      width: getSize(56),
                                      padding: getPadding(
                                        all: 16,
                                      ),
                                      decoration: IconButtonStyleHelper.fillGray1,
                                      child: CustomImageView(
                                        svgPath: AppIcons.slpashIcon,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 12,
                                        right: 12,
                                        top: 4,
                                        bottom: 3,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${transaction.type}",
                                            style: CustomTextStyles.titleMedium18,
                                          ),
                                          Text(
                                            "${transaction.date}",
                                            style: CustomTextStyles.bodyMedium13,
                                          ), Text(
                                            "${transaction.litre} L",
                                            style: CustomTextStyles.bodyMedium13,
                                          ), Text(
                                            "${transaction.price} Dhs",
                                            style: CustomTextStyles.bodyMedium13,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: getPadding(
                                        top: 3,
                                        right: 1,
                                        bottom: 25,
                                      ),
                                      child: Text(
                                        "${transaction.totale} Dhs",
                                        style: CustomTextStyles.titleMediumDeeporangeA700,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
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
