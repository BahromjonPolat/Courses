import 'dart:async';

import 'package:courses/components/size_config.dart';
import 'package:courses/constants/colors.dart';
import 'package:courses/screens/home/home_page.dart';
import 'package:courses/screens/upload/upload_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const UploadingPage(),
        ),
      );
    });
    return Scaffold(
      backgroundColor: ConstColors.backgroundColor,
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        const Spacer(),
        Center(
          child: SvgPicture.asset(
            "assets/icons/logo.svg",
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
    );
  }
}
