import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/components/size_config.dart';
import 'package:courses/constants/colors.dart';
import 'package:courses/constants/icons.dart';
import 'package:courses/models/course_model.dart';
import 'package:courses/models/video_lesson_model.dart';
import 'package:courses/screens/player/video_player_page.dart';
import 'package:courses/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LessonListPage extends StatefulWidget {
  Course course;

  LessonListPage(this.course, {Key? key}) : super(key: key);

  @override
  State<LessonListPage> createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> {
  Course? _course;

  @override
  void initState() {
    super.initState();
    _course = widget.course;
  }

  @override
  Widget build(BuildContext context) {
    _getVideos();
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  FutureBuilder<List<VideoModel>> _buildBody() {
    return FutureBuilder(
        future: _getVideos(),
        builder: (context, AsyncSnapshot<List<VideoModel>> snap) {
          if (snap.hasData) {
            return ListView.builder(
                itemCount: snap.data!.length,
                itemBuilder: (context, index) {
                  return _setVideoLessonLayout(snap.data![index]);
                });
          } else if (snap.hasError) {
            return SetTextWidget("Error");
          }
          return const Center(child: CupertinoActivityIndicator());
        });
  }

  AppBar _buildAppBar() => AppBar(
        iconTheme: const IconThemeData(color: ConstColors.black),
        backgroundColor: ConstColors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: SetTextWidget(
          _course!.name,
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

  _setVideoLessonLayout(VideoModel video) => InkWell(
        onTap: () {
          // print(video.videoUrl);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => VideoPlayerPage(video.videoUrl)));
        },
        child: Container(
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
                  "https://i.ytimg.com/vi/69pxFJF5SkY/maxresdefault.jpg",
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
                        video.title,
                        weight: FontWeight.w700,
                      ),
                      SetTextWidget(
                        video.description,
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
        ),
      );

  Future<List<VideoModel>> _getVideos() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    var data = await fireStore
        .collection("Videos")
        .where('courseId', isEqualTo: _course!.id)
        .get();

    return data.docs
        .map((e) => VideoModel.fromJson({
              'id': e['id'],
              'title': e['title'],
              'description': e['description'],
              'videoUrl': e['videoUrl'],
              'duration': e['duration'],
              'uploadedDate': e['uploadedDate'],
              'courseId': e['courseId'],
            }))
        .toList();
  }
}
