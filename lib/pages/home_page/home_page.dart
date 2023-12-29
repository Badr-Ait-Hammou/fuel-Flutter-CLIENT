import 'package:fuelflutter/components/app_bar/appbar_image.dart';
import 'package:fuelflutter/components/app_bar/appbar_title.dart';
import 'package:fuelflutter/components/app_bar/custom_app_bar.dart';
import 'package:fuelflutter/components/app_icons.dart';
import 'package:fuelflutter/core/utils/size_utils.dart';
import 'package:fuelflutter/model/fuel.model.dart';
import 'package:fuelflutter/pages/home_page/components/submit_page.dart';
import 'package:fuelflutter/routes.dart';
import 'package:fuelflutter/service/user.service.dart';
import 'package:fuelflutter/theme/app_decoration.dart';
import 'package:fuelflutter/theme/custom_text_style.dart';
import 'package:fuelflutter/theme/theme_helper.dart';

import 'components/options_item_widget.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<FuelModel> fuelPricesFuture;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    fuelPricesFuture = UserService().getFuelPrices();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: appTheme.gray100,
        appBar: CustomAppBar(
            leadingWidth: getHorizontalSize(68),
            leading: AppbarImage(
                svgPath: AppIcons.imgGrid,
                margin: getMargin(left: 24, top: 6, bottom: 6)),
            title: AppbarTitle(
                text: "Welcome Back!", margin: getMargin(left: 23))),
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
              // Expanded(
              //     child: Padding(
              //         padding: getPadding(left: 3, top: 50, right: 3),
              //         child: GridView.builder(
              //             shrinkWrap: true,
              //             gridDelegate:
              //                 SliverGridDelegateWithFixedCrossAxisCount(
              //                     mainAxisExtent: getVerticalSize(201),
              //                     crossAxisCount: 2,
              //                     mainAxisSpacing: getHorizontalSize(24),
              //                     crossAxisSpacing: getHorizontalSize(24)),
              //             physics: const BouncingScrollPhysics(),
              //             itemCount: 3,
              //             itemBuilder: (context, index) {
              //               return OptionsItemWidget(onTapOne: () {
              //                 onTapOne(context);
              //               });
              //             }))),
              FutureBuilder(
                future: fuelPricesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    FuelModel fuelPrices = snapshot.data as FuelModel;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        priceCard(
                          title: 'Gasoil',
                          price: fuelPrices.gasoil,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 16),
                        priceCard(
                          title: 'SansPlomb',
                          price: fuelPrices.sansPlomb,
                          color: Colors.green,
                        ),
                        SizedBox(height: 16),
                        priceCard(
                          title: 'Excellium',
                          price: fuelPrices.excellium,
                          color: Colors.orange,
                        ),
                      ],
                    );
                  }
                },
              ),
            ])),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) {
                return SubmitPage(
                  modalHeight: MediaQuery.of(context).size.height * 0.75,
                );
              },
            );
          },
          tooltip: 'Add',
          child: Icon(Icons.add),
        ));
  }

  onTapOne(BuildContext context) {
    // Navigator.pushNamed(context, Routes.mobilePrepaidOneScreen);
  }

  Widget priceCard({
    required String title,
    required double price,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '$price MAD',
              style: TextStyle(fontSize: 24, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
