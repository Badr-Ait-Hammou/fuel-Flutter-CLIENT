import 'package:fuelflutter/components/app_bar/appbar_image.dart';
import 'package:fuelflutter/components/app_bar/appbar_title.dart';
import 'package:fuelflutter/components/app_bar/custom_app_bar.dart';
import 'package:fuelflutter/components/app_icons.dart';
import 'package:fuelflutter/core/utils/size_utils.dart';
import 'package:fuelflutter/model/fuel.model.dart';
import 'package:fuelflutter/pages/home_page/components/submit_page.dart';
import 'package:fuelflutter/service/user.service.dart';
import 'package:fuelflutter/theme/app_decoration.dart';
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
    String formattedDate = DateFormat('dd MMM yy').format(DateTime.now());

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
                        Text("Total Operations",
                            style: CustomTextStyles.bodyLargeGray10001),
                        Text("500 Dhs",
                            style: CustomTextStyles.displayMediumGray10001)
                      ])),

                  Padding(
                    padding: getPadding(
                      left: 1,
                      top: 40,
                      right: 1,
                    ),
                      child: Container(
                        width: getHorizontalSize(360),
                        padding: getPadding(left: 10, top: 5, right: 10, bottom: 5),
                       // color: Colors.white60 ,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.grey[300]),
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Today",
                          style: theme.textTheme.headlineMedium,
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
                      )
                  ),
              SizedBox(
                height: getVerticalSize(10),
                width: getHorizontalSize(390),
              ),
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

    return Container(
      padding: getPadding(
        left: 16,
        top: 20,
        right: 16,
        bottom: 12,
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
              top: 3,
              right: 46,
              bottom: 25,
            ),
            child: Text(
              "",
              style: CustomTextStyles.titleMediumDeeporangeA700,
            ),
          ),
        ],
      ),
    );
  }
}
