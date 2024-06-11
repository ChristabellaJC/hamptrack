import 'package:dev_hampter/screens/welcome_page.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';
import 'dart:async';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final bool _visible = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.2,
                0.6,
                0.9,
              ],
              colors: [
                Color(0xFFFFED9E),
                Color(0xFFFFE675),
                Color(0xFFE9C317),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('assets/images/splashMou.png', width: 180),
                const SizedBox(height: 15),
                StrokeText(
                  textAlign: TextAlign.center,
                  text: "HampTrack",
                  textStyle: TextStyle(
                    fontFamily: 'BalooThambi2',
                    fontSize: 47,
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                    shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(1.0, 5.0),
                        blurRadius: 5.0,
                        color: shadowColor,
                      ),
                    ],
                  ),
                  strokeColor: textColor,
                  strokeWidth: 5,
                ),
                StrokeText(
                  textAlign: TextAlign.center,
                  text: "HampTrack",
                  textStyle: TextStyle(
                    fontFamily: 'BalooThambi2',
                    fontSize: 25,
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                    shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(1.0, 5.0),
                        blurRadius: 5.0,
                        color: shadowColor,
                      ),
                    ],
                  ),
                  strokeColor: textColor,
                  strokeWidth: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
