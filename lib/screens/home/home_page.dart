import 'package:flutter/material.dart';
import 'package:courses/components/exporting_packages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentCategoryIndex = 0;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  List<Course>? _courseList;
  late List<Course> _currentCourse;
  late String _currentCategoryId;

  @override
  void initState() {
    super.initState();

    _getCourseList().then((value) {
      _courseList = value;
      setState(() {});
    });
  }

  _setCurrentCourseList() {
    for (Course course in _courseList!) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: _buildBody(),
    );
  }

  CustomScrollView _buildBody() =>
      CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _showSearchField(),
          _showCategories(),
          _showCourseTitle(),
          _courseList != null
              ? SliverList(
              delegate: SliverChildListDelegate(

                  List.generate(
                      _courseList!.length,
                          (index) =>
                          _setLessonInfoLayout(_courseList![index]))))
              : SliverToBoxAdapter(
            child: SetTextWidget("Null"),
          ),
        ],
      );

  InkWell _setLessonInfoLayout(Course course) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => LessonListPage(course)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16.0),
            vertical: getProportionateScreenHeight(5.5)),
        height: getProportionateScreenHeight(211.0),
        width: MediaQuery
            .of(context)
            .size
            .width,
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(course.imageUrl),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(8.0)),
            SetTextWidget(
              course.name,
              weight: FontWeight.w700,
            ),
            SetTextWidget(
              course.description,
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

  SliverAppBar _buildSliverAppBar() =>
      SliverAppBar(
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

  _showSearchField() =>
      SliverToBoxAdapter(
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

  OutlineInputBorder _setInputBorder() =>
      OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      );

  SliverToBoxAdapter _showCategories() =>
      SliverToBoxAdapter(
        child: SizedBox(
          height: getProportionateScreenHeight(149.0),
          child: FutureBuilder(
            future: _getCategories(),
            builder: (context, AsyncSnapshot<List<Category>> snap) {
              if (snap.hasData) {
                return ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 3.0, vertical: 24.0),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(snap.data!.length, (index) {
                    Category category = snap.data![index];
                    return _setCategoryLayout(
                        category.name, category.imageUrl, index);
                  }),
                );
              } else if (snap.hasError) {
                SetTextWidget("ERROR");
              }
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            },
          ),
        ),
      );

  InkWell _setCategoryLayout(String title, String icon, int index) =>
      InkWell(
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
              child: SvgPicture.network(
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

  Future<List<Category>> _getCategories() async {
    QuerySnapshot categories = await _fireStore
        .collection('VideoLessonCategories')
        .orderBy('timestamp')
        .get();

    return categories.docs
        .map((e) =>
        Category.fromJson({
          'id': e['id'],
          'name': e['name'],
          'imageUrl': e['imageUrl'],
        }))
        .toList();
  }

  Future<List<Course>> _getCourseList() async {
    QuerySnapshot courses =
    await _fireStore.collection('VideoLessonCourseList').get();

    return courses.docs
        .map((e) =>
        Course.fromJson({
          'id': e['id'],
          'name': e['name'],
          'description': e['description'],
          'imageUrl': e['imageUrl'],
          'price': e['price'],
          'percentOfLike': e['percentOfLike'],
          'categoryId': e['categoryId'],
          'amount': e['amount'],
        }))
        .toList();
  }

  final List<String> _courseTitles = [
    "Dasturlash",
    "Dizayn",
    "SMM",
    "Til kurslari"
  ];
}
