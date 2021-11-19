import 'dart:async';

import 'package:courses/components/size_config.dart';
import 'package:courses/constants/colors.dart';
import 'package:courses/screens/home/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    });
    return Scaffold(
      backgroundColor: ConstColors.backgroundColor,
      body: Stack(
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              height: getProportionateScreenHeight(189.99),
            ),
          ),
          const Spacer(),
          Positioned(
            bottom: getProportionateScreenHeight(93.08),
            left: getProportionateScreenWidth(0.0),
            right: getProportionateScreenWidth(0.0),
            child: const Text(
              "ORGANAPP",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ConstColors.lightGrey,
                fontSize: 27.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
