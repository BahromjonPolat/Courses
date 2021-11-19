import 'package:courses/components/size_config.dart';
import 'package:courses/constants/colors.dart';
import 'package:courses/constants/icons.dart';
import 'package:courses/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  CustomScrollView _buildBody() => CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _showSearchField(),
        ],
      );

  SliverAppBar _buildSliverAppBar() => SliverAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: ConstColors.transparent,
        toolbarHeight: getProportionateScreenHeight(103.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SetTextWidget(
              "Qanday darslar sizni \nqiziqtiradi?",
              weight: FontWeight.w700,
              size: 25.0,
            ),
            SetTextWidget("28 xil yo`nalishda darsliklar mavjud", size: 12.0)
          ],
        ),
      );

  _showSearchField() => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              filled: true,
              fillColor: ConstColors.lightGrey,
              hintText: "Izlash",
              border: _setInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              suffixIcon: const Icon(CupertinoIcons.search),
            ),
          ),
        ),
      );

  OutlineInputBorder _setInputBorder() => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      );


}
