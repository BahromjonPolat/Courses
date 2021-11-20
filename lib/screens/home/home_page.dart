import 'package:courses/components/size_config.dart';
import 'package:courses/constants/colors.dart';
import 'package:courses/constants/icons.dart';
import 'package:courses/screens/list/lesson_list_page.dart';
import 'package:courses/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: _buildBody(),
    );
  }

  CustomScrollView _buildBody() => CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _showSearchField(),
          _showCategories(),
          _showCourseTitle(),
          _setLessonInfoLayout(),
          _setLessonInfoLayout(),
          _setLessonInfoLayout(),
        ],
      );

  SliverToBoxAdapter _setLessonInfoLayout() {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> LessonListPage()));
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16.0),
              vertical: getProportionateScreenHeight(5.5)),
          height: getProportionateScreenHeight(211.0),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(getProportionateScreenWidth(7.0)),
          decoration: BoxDecoration(
            color: ConstColors.lightGrey,
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(10.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: getProportionateScreenHeight(132.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("https://source.unsplash.com/random/475"),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(8.0)),
              SetTextWidget(
                "UX/UI dizayn",
                weight: FontWeight.w700,
              ),
              SetTextWidget(
                "Boshlang`ich darajadagilar uchun",
                weight: FontWeight.w400,
                size: getProportionateScreenWidth(12.0),
              ),
              SetTextWidget(
                ":) 97%",
                size: getProportionateScreenWidth(12.0),
                textColor: ConstColors.tealBlue,
                weight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _showCourseTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16.0)),
        child: SetTextWidget(
          "${_courseTitles[_currentCategoryIndex]}ga oid kurslar",
          size: getProportionateScreenWidth(16.0),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() => SliverAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: ConstColors.white,
        floating: true,
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
            cursorColor: ConstColors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: ConstColors.lightGrey,
              hintText: "Izlash",
              border: _setInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              suffixIcon: SvgPicture.asset(IconName.search, fit: BoxFit.none),
            ),
          ),
        ),
      );

  OutlineInputBorder _setInputBorder() => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      );

  SliverToBoxAdapter _showCategories() => SliverToBoxAdapter(
        child: SizedBox(
          height: getProportionateScreenHeight(149.0),
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 3.0, vertical: 24.0),
            scrollDirection: Axis.horizontal,
            children: [
              _setCategoryLayout(_courseTitles[0], IconName.programming, 0),
              _setCategoryLayout(_courseTitles[1], IconName.design, 1),
              _setCategoryLayout(_courseTitles[2], IconName.smm, 2),
              _setCategoryLayout(_courseTitles[3], IconName.languages, 3),
            ],
          ),
        ),
      );

  InkWell _setCategoryLayout(String title, String icon, int index) => InkWell(
        onTap: () {
          setState(() {
            _currentCategoryIndex = index;
          });
        },
        child: Column(
          children: [
            Container(
              height: getProportionateScreenHeight(72.0),
              width: getProportionateScreenWidth(71.0),
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(13)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: _currentCategoryIndex == index
                    ? ConstColors.tealBlue
                    : ConstColors.lightGrey,
              ),
              child: SvgPicture.asset(
                icon,
                fit: BoxFit.none,
                height: getProportionateScreenHeight(35.0),
                width: getProportionateScreenWidth(35.0),
                color: _currentCategoryIndex == index
                    ? ConstColors.lightGrey
                    : ConstColors.black,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(11.0)),
            SetTextWidget(title, size: getProportionateScreenWidth(12.0))
          ],
        ),
      );

  final List<String> _courseTitles = [
    "Dasturlash",
    "Dizayn",
    "SMM",
    "Til kurslari"
  ];
}
