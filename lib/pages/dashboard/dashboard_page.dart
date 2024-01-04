import 'package:flutter/material.dart';
import 'package:fuelflutter/components/app_bar/appbar_image.dart';
import 'package:fuelflutter/components/app_bar/appbar_title.dart';
import 'package:fuelflutter/components/app_bar/custom_app_bar.dart';
import 'package:fuelflutter/components/app_icons.dart';
import 'package:fuelflutter/core/utils/size_utils.dart';
import 'package:fuelflutter/model/chart.dart';
import 'package:fuelflutter/pages/dashboard/components/custom_card.dart';
import 'package:fuelflutter/pages/dashboard/components/pie_chart.dart';
import '../../components/custom_icon_button.dart';
import '../../components/custom_image_view.dart';
import '../../model/operation.model.dart';
import '../../service/dashboard.service.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import 'package:intl/intl.dart';

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
    _fetchTransactions();
    init();
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

  List<ChartDataOne> chatOne = [];
  List<ChartDataOne> chatOneFinal = [];

  Future<void> init() async {
    chatOne = await DashboardService().getPieOne();
    if (chatOne.isNotEmpty) {
      setState(() {
        chatOneFinal = chatOne;
      });
    }
    print(chatOne);
    }

  void _deleteTransaction(int transactionId) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this transaction?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        DashboardService dashboardService = DashboardService();
        await dashboardService.deleteTransaction(transactionId);
        print('Transaction deleted successfully');
      } catch (e) {
        print('Error deleting transaction: $e');
      }
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
          svgPath: AppIcons.whiteLogo,
          margin: getMargin(left: 24, top: 6, bottom: 6),
        ),
        title: AppbarTitle(text: "Dashboard", margin: getMargin(left: 23)),
      ),
      body: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            // CustomCard(
            //   title: 'CHART',
            //   content: PieChartDash(
            //     dataSource: kChartData,
            //   ),
            // ),
            CustomCard(
                title: 'CHART',
                content: PieChartDash(
                  dataSource: chatOneFinal,
                ),
            ),
            // SizedBox(
            //   height: height * 0.43,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         SizedBox(height: height * 0.065),
            //         const Text(
            //           'Monthly Expenses',
            //         ),
            //         const Expanded(
            //           child: Row(
            //             children: <Widget>[
            //               CategoriesRow(),
            //               PieChart(),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // CustomCard(
            //   title: 'Monthly Expenses',
            //   content: SizedBox(
            //     height: height * 0.55,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 5.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           SizedBox(height: height * 0.0001),
            //           const Text(
            //             'Monthly Expenses',
            //           ),
            //           const Expanded(
            //             child: AspectRatio(
            //               aspectRatio: 20 / 9,
            //               child: LineChartSample1(),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // CustomCard(
            //   title: 'Monthly Expenses',
            //   content: SizedBox(
            //     height: height * 0.55,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 5.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           SizedBox(height: height * 0.0001),
            //           const Text(
            //             'Monthly Expenses',
            //           ),
            //           const Expanded(
            //             child: AspectRatio(
            //               aspectRatio: 20 / 9,
            //               child: PieChartSample2(),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            CustomCard(
              title:'My Expenses',
              content: SizedBox(
                height: height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: height * 0.0001),
                      Expanded(
                        child: Padding(
                          padding: getPadding(
                            left: 1,
                            top: 1,
                            right: 1,
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
                              String formattedDate = DateFormat('EEEE, hh:mm a').format(transaction.date);


                              return Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    _deleteTransaction(transaction.id);
                                    setState(() {
                                      _transactions.removeAt(index);
                                    });
                                  },
                                  background: Container(
                                    alignment: AlignmentDirectional.centerEnd,
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.red,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 16.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    padding: getPadding(
                                      left: 10,
                                      top: 10,
                                      right: 10,
                                      bottom: 10,
                                    ),
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                     child: Row(
                                        children: [
                                          CustomIconButton(
                                            height: getSize(40),
                                            width: getSize(40),
                                            padding: getPadding(
                                              all: 1,
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
                                                Row(
                                                  children: [
                                                    const Icon(Icons.merge_type_outlined, size: 20, color: Colors.black),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      transaction.type,
                                                      style: CustomTextStyles.titleMedium18,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.date_range, size: 20, color: Colors.black),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      formattedDate,
                                                      style: CustomTextStyles.bodyMedium13,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.local_gas_station, size: 20, color: Colors.black),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      "${transaction.litre} L",
                                                      style: CustomTextStyles.bodyMedium13,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.attach_money, size: 20, color: Colors.black),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      "${transaction.price} Dhs",
                                                      style: CustomTextStyles.bodyMedium13,
                                                    ),
                                                  ],
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
                                            child: Row(
                                              children: [
                                                const Icon(Icons.monetization_on, size: 20, color: Colors.deepOrange),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "${transaction.totale} Dhs",
                                                  style: CustomTextStyles.titleMediumDeeporangeA700,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )

                                  )
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
