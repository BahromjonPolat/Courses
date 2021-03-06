import 'package:courses/constants/colors.dart';
import 'package:courses/screens/upload/add_category.dart';
import 'package:courses/screens/upload/add_lesson_page.dart';
import 'package:courses/screens/upload/uploading_video_page.dart';
import 'package:courses/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadingPage extends StatefulWidget {
  const UploadingPage({Key? key}) : super(key: key);

  @override
  _UploadingPageState createState() => _UploadingPageState();
}

class _UploadingPageState extends State<UploadingPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _getBodyList()[_currentIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor: ConstColors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: SetTextWidget(
          _titles[_currentIndex],
          weight: FontWeight.w700,
          size: 21.0,
        ),
      );

  final List<String> _titles = ["Add Category", "Add Lesson", "Upload Video"];

  List<Widget> _getBodyList() => [
        const AddingCategory(),
        const AddingLessonPage(),
        const UploadingVideoPage(),
      ];

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        items: _bottomNavBarItems,
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
      );
  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: "Category",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.play_lesson),
      label: "Lesson",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.video_call_outlined),
      label: "Video",
    ),
  ];
}
