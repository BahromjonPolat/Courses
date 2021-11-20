import 'package:courses/components/size_config.dart';
import 'package:courses/constants/colors.dart';
import 'package:courses/constants/icons.dart';
import 'package:courses/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LessonListPage extends StatefulWidget {
  const LessonListPage({Key? key}) : super(key: key);

  @override
  State<LessonListPage> createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  ListView _buildBody() {
    return ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index) {
          return _setVideoLessonLayout();
        });
  }

  AppBar _buildAppBar() => AppBar(
        iconTheme: const IconThemeData(color: ConstColors.black),
        backgroundColor: ConstColors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: SetTextWidget(
          "UX/UI darslari",
          weight: FontWeight.w700,
          size: 25.0,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 21.0,
            padding: EdgeInsets.all(getProportionateScreenWidth(16.0)),
            icon: SvgPicture.asset(IconName.message),
          )
        ],
      );

  _setVideoLessonLayout() => Container(
        height: getProportionateScreenHeight(140.0),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16.0),
          vertical: getProportionateScreenHeight(6.0),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: ConstColors.lightGrey,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
              child: Image.network(
                "https://source.unsplash.com/random/45",
                width: getProportionateScreenWidth(140.0),
                height: getProportionateScreenHeight(140.0),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(12.0),
                    vertical: getProportionateScreenHeight(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SetTextWidget(
                      "UX/UI nima? Soha haqida umumiy tushuncha.",
                      weight: FontWeight.w700,
                    ),
                    SetTextWidget(
                      "Abbos Xazratov",
                      weight: FontWeight.w400,
                      size: getProportionateScreenWidth(12.0),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SetTextWidget(
                          "2 kun oldin yuklandi",
                          size: getProportionateScreenWidth(12.0),
                        ),
                        SvgPicture.asset(
                          IconName.playOffline,
                          fit: BoxFit.none,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );


}
