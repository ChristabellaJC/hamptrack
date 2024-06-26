import 'package:dev_hampter/components/bottomnavbar.dart';
import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:dev_hampter/components/settingfields.dart';
import 'package:dev_hampter/components/buttons.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final TextEditingController _usernameController = TextEditingController();
  double height = 0, width = 0;
  String _userId = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  //Function to load user data
  Future<void> _loadUserData() async {
    try {
      final auth = Auth();
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await auth.getUserByEmail(user.email!);
        final userData = userDoc.data();
        if (userData != null) {
          _usernameController.text = userData['Username'];
          _userId = user.uid;
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  //Function to update current user data
  Future<void> _updateUserData() async {
    try {
      final auth = Auth();
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await auth.getUserByEmail(user.email!);
        final userData = userDoc.data();
        _userId = userDoc.id;

        if (userData != null) {
          final updatedUserData = {
            'Username': _usernameController.text.trim(),
          };

          await auth.updateUserData(_userId, updatedUserData);

          Get.snackbar(
            "Success",
            "Username updated successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: primaryColor,
            colorText: textColor,
          );
        } else {
          throw Exception('User data is null');
        }
      } else {
        throw Exception('Current user is null');
      }
    } catch (e) {
      Get.snackbar(
        "Failure",
        "Username can't be update $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColor,
        colorText: textColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 90, 15, 40),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              color: Colors.transparent,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: padding,
                height: height * .8,
                width: width,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: accPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.to(() => NavBar());
                                },
                                icon: Icon(
                                  Icons.highlight_off,
                                  color: iconColor,
                                  size: titleAccFont,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Settings',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: titleAccFont,
                                    fontFamily: 'BalooThambi2',
                                    fontWeight: FontWeight.w800,
                                    color: textColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          SettingFields(
                              label: 'Username',
                              controller: _usernameController),
                          const SizedBox(height: 32),
                          Center(
                            child: CustomButton(
                              enabledText: 'Save Changes',
                              onPressed: _updateUserData,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
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
