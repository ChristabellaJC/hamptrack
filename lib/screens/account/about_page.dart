import 'package:dev_hampter/components/feature_item.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:dev_hampter/components/bottomnavbar.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:get/get.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  double height = 0, width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: height * 0.8,
            width: width,
            padding: padding,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: accPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(() => const NavBar());
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
                          'About Us',
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
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: accPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome to HampTrack!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'HampTrack is your ultimate companion for managing your finances efficiently and effectively. Our app is designed to help you keep track of your expenses, set budgets, and achieve your financial goals. Whether you\'re saving for a big purchase, managing daily expenses, or just want to get a better understanding of your spending habits, HampTrack has you covered.',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Meet Mou, Your Financial Buddy',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'HampTrack features an adorable mascot named Mou, who helps you keep an eye on your expenses. Mou’s well-being reflects your financial health.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Why HampTrack?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'At HampTrack, we believe that managing your finances should be simple and stress-free. Our user-friendly interface and helpful features are designed to give you control over your money without overwhelming you. Whether you’re looking to save more, spend smarter, or just get a better handle on your finances, HampTrack is here to support you every step of the way.',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Features',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const FeatureItem(
                              title: 'Sign In and Sign Up',
                              description:
                                  'Create a new account or sign in to your existing one to start tracking your finances. Your data is securely stored and accessible only to you.',
                            ),
                            const FeatureItem(
                              title: 'Homepage',
                              description:
                                  'Set your budget and let HampTrack help you stick to it. Our adorable mascot, Mou, helps you visualize your financial health. If your expenses exceed your budget, Mou will appear unwell. Keep your expenses under control to keep Mou healthy and happy!',
                            ),
                            const FeatureItem(
                              title: 'Detail Page',
                              description:
                                  'Get an overview of your financial status at a glance. See your total income, expenses, and current budget status. Review your financial history.',
                            ),
                            const FeatureItem(
                              title: 'Add Expense and Income',
                              description:
                                  'Quickly add your daily expenses or income.',
                            ),
                            const FeatureItem(
                              title: 'Account Page',
                              description:
                                  'Customize your settings by changing your username, editing your budget, and logging out.',
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Developed by',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '535220166 - Christabella Jocelynne Chandra\n535220170 - Angela Chow\n535220187 - Jessica Ho\n535220207 - Kelly Christella Gywen\n535220226 - Parveen Uzma',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Illustrated by',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '535220166 - Christabella Jocelynne Chandra',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    height: height * .05,
                    color: primaryColor,
                    child: Center(
                      child: Text(
                        'Dev_Hampter',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
