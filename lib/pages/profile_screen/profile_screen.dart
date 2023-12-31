import 'package:flutter/material.dart';
import 'package:fuelflutter/components/app_bar/appbar_image.dart';
import 'package:fuelflutter/components/app_bar/appbar_title.dart';
import 'package:fuelflutter/components/app_bar/custom_app_bar.dart';
import 'package:fuelflutter/components/app_icons.dart';
import 'package:fuelflutter/components/custom_bottom_bar.dart';
import 'package:fuelflutter/components/custom_image_view.dart';
import 'package:fuelflutter/core/utils/size_utils.dart';
import 'package:fuelflutter/model/user.model.dart';
import 'package:fuelflutter/pages/Login_Page.dart';
import 'package:fuelflutter/pages/dashboard/dashboard_page.dart';
import 'package:fuelflutter/pages/home_page/home_page.dart';
import 'package:fuelflutter/routes.dart';
import 'package:fuelflutter/service/storage.service.dart';
import 'package:fuelflutter/theme/custom_text_style.dart';
import 'package:fuelflutter/theme/theme_helper.dart';

import '../../components/custom_elevated_button.dart';
import '../../service/user.service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserModel> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = UserService().getUserInfo();
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
      body: FutureBuilder(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('User data not available'));
          } else {
            final userData = snapshot.data as UserModel;
            return Container(
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
                      "${userData.prenom} ${userData.nom}",
                      style: theme.textTheme.displayMedium,
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 8,
                    ),
                    child: Text(
                      userData.email,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  // Rows 1-3
                  buildProfileRow(
                    imagePath: AppIcons.imgSettings,
                    label: userData.nom,
                  ),
                  buildProfileRow(
                    imagePath: AppIcons.imgFingerprint,
                    label: userData.prenom,
                  ),
                  buildProfileRow(
                    imagePath: AppIcons.imgCut,
                    label: userData.email,
                  ),
                  // Buttons
                  buildButton(
                    label: "Logout",
                    onTap: () {
                      onTapSignOut(context);
                    },
                  ),
                  buildButton(
                    label: "Update Profile",
                    onTap: () {
                      _showUpdateProfileDialog(context);
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _showUpdateProfileDialog(BuildContext context) async {
    final TextEditingController nomController = TextEditingController();
    final TextEditingController prenomController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: prenomController,
                decoration: InputDecoration(labelText: 'Prenom'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                print(_userDataFuture);
                final String updatedNom = nomController.text;
                final String updatedPrenom = prenomController.text;
                try {
                  await UserService().updateProfile(updatedNom, updatedPrenom);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully'),
                    ),
                  );
                } catch (e) {
                  print('Error updating profile: $e');
                  String errorMessage = 'Failed to update profile';
                  Navigator.of(context).pop();

                  if (e is FormatException) {
                    errorMessage = 'Invalid server response format';
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                    ),
                  );
                }

              },
              child: Text('Update'),
            ),

          ],
        );
      },
    );
  }
}
  Widget buildProfileRow({
    required String imagePath,
    required String label,
  }) {
    return Padding(
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
            svgPath: imagePath,
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
              label,
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
    );
  }

  Widget buildButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
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
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                primary: theme.colorScheme.primary,
              ),
              child: Text(
                label,
                style: CustomTextStyles.titleLargeSemiBold,
              ),
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
    );
  }


onTapSignOut(BuildContext context) async {
  try {
    await StorageService().deleteAll();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  } catch (e) {
    print('Error during sign out: $e');
    // Handle errors as needed
  }
}