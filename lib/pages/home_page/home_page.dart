import 'package:fuelflutter/components/app_bar/appbar_image.dart';
import 'package:fuelflutter/components/app_bar/appbar_title.dart';
import 'package:fuelflutter/components/app_bar/custom_app_bar.dart';
import 'package:fuelflutter/components/app_icons.dart';
import 'package:fuelflutter/core/utils/size_utils.dart';
import 'package:fuelflutter/model/fuel.model.dart';
import 'package:fuelflutter/pages/home_page/components/submit_page.dart';
import 'package:fuelflutter/service/user.service.dart';
import 'package:fuelflutter/theme/custom_text_style.dart';
import 'package:fuelflutter/theme/theme_helper.dart';
import '../../components/custom_icon_button.dart';
import '../../components/custom_image_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<FuelModel> fuelPricesFuture;
  late Future<List<List<dynamic>>> fuelAmountsFuture;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    fuelPricesFuture = UserService().getFuelPrices();
    fuelAmountsFuture = UserService().getFuelAmounts();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    String formattedDate = DateFormat('dd MMM yy').format(DateTime.now());
    return Scaffold(
      backgroundColor: appTheme.gray100,
      appBar: CustomAppBar(
        leadingWidth: getHorizontalSize(68),
        leading: AppbarImage(
          svgPath: AppIcons.whiteLogo,
          margin: getMargin(left: 24, top: 6, bottom: 6),
        ),
        title: AppbarTitle(
          text: "Welcome Back!",
          margin: getMargin(left: 23),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        padding: getPadding(left: 24, top: 20, right: 24, bottom: 34),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: getPadding(left: 1, top: 5, right: 1, bottom: 5),
              child: Container(
                width: getHorizontalSize(360),
                padding: getPadding(
                  left: 10,
                  top: 5,
                  right: 10,
                  bottom: 5,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Today",
                      style: CustomTextStyles.titleMedium18,
                    ),
                    Spacer(),
                    Padding(
                      padding: getPadding(
                        top: 11,
                        bottom: 9,
                      ),
                      child: Text(
                        formattedDate,
                        style: CustomTextStyles.titleMedium18,
                      ),
                    ),
                    CustomImageView(
                      svgPath: AppIcons.imgPlay,
                      height: getVerticalSize(15),
                      width: getHorizontalSize(15),
                      margin: getMargin(
                        left: 5,
                        top: 2,
                        bottom: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: Future.wait([fuelPricesFuture, fuelAmountsFuture]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      FuelModel fuelPrices = snapshot.data?[0] as FuelModel;
                      List<List<dynamic>> fuelAmounts = snapshot.data?[1] as List<List<dynamic>>;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          priceCard(
                            title: 'Gasoil',
                            price: fuelPrices.gasoil,
                          ),
                          SizedBox(height: 10),
                          priceCard(
                            title: 'SansPlomb',
                            price: fuelPrices.sansPlomb,
                          ),
                          SizedBox(height: 10),
                          priceCard(
                            title: 'Excellium',
                            price: fuelPrices.excellium,
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: getHorizontalSize(360),
                            padding: getPadding(
                              left: 10,
                              top: 5,
                              right: 10,
                              bottom: 5,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[300]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "My Summary",
                                  style: CustomTextStyles.titleMedium18,
                                ),
                                Spacer(),
                                Padding(
                                  padding: getPadding(
                                    top: 11,
                                    bottom: 9,
                                  ),

                                ),
                                CustomImageView(
                                  svgPath: AppIcons.imgArrowDown,
                                  height: getVerticalSize(15),
                                  width: getHorizontalSize(15),
                                  margin: getMargin(
                                    left: 5,
                                    top: 2,
                                    bottom: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getVerticalSize(10),
                          ),
                          totalOperationsCard(fuelAmounts),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(44, 43, 31, 1.0),
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
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
  Widget totalOperationsCard(List<List<dynamic>> fuelAmounts) {
    return Container(
      padding: getPadding(
        left: 16,
        top: 20,
        right: 16,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: Offset(2, 4),
            blurRadius: 5,
          ),
        ],
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          for (var fuelAmount in fuelAmounts)
            Container(
              margin: EdgeInsets.only(bottom: 16),
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
                              "${fuelAmount[0]}:",
                              style: CustomTextStyles.titleMedium18,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.local_gas_station, size: 20, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                              "${fuelAmount[2].toStringAsFixed(2)} Liters",
                              style: CustomTextStyles.titleMediumDeeporangeA700,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: getPadding(
                      top: 10,
                      right: 10,
                      bottom: 30,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.attach_money, size: 20, color: Colors.teal),
                        SizedBox(width: 5),
                        Text(
                          "${fuelAmount[1]} Dhs",
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 150, 136, 1.0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget priceCard({
    required String title,
    required double price,
  }) {
    return Container(
      padding: getPadding(
        left: 16,
        top: 10,
        right: 16,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: Offset(2, 4),
            blurRadius: 5,
          ),
        ],
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
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
              top: 4,
              bottom: 3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CustomTextStyles.titleMedium18,
                ),
                Text(
                  '$price MAD',
                  style: CustomTextStyles.bodyMedium13,
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: getPadding(
              top: 10,
              right: 10,
              bottom: 30,
            ),
            child: CustomImageView(
              svgPath: AppIcons.imgContrast,
            ),
          ),
        ],
      ),
    );
  }
}
