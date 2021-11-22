import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/constants/colors.dart';
import 'package:courses/models/course_model.dart';
import 'package:courses/models/video_lesson_model.dart';
import 'package:courses/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class UploadingVideoPage extends StatefulWidget {
  const UploadingVideoPage({Key? key}) : super(key: key);

  @override
  _UploadingVideoPageState createState() => _UploadingVideoPageState();
}

class _UploadingVideoPageState extends State<UploadingVideoPage> {
  final _uuid = const Uuid();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _videoUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _courseId = '';

  @override
  Widget build(BuildContext context) {
    print(_courseId);
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFutureBuilder(),
          TextField(
            controller: _titleController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            decoration: _setInputDecoration("Title"),
          ),
          TextField(
            controller: _descriptionController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            maxLines: 6,
            textCapitalization: TextCapitalization.sentences,
            decoration: _setInputDecoration("Description"),
          ),
          TextField(
            controller: _videoUrlController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            // textCapitalization: TextCapitalization.sentences,
            decoration: _setInputDecoration("Lesson url"),
          ),
          ElevatedButton(
              onPressed: _onAddButtonPressed, child: SetTextWidget("Add Video"))
        ],
      ),
    );
  }

  FutureBuilder<List<Course>> _buildFutureBuilder() {
    return FutureBuilder(
        future: _getCaourseList(),
        builder: (context, AsyncSnapshot<List<Course>> snap) {
          if (snap.hasError) {
            return Center(
              child: SetTextWidget("ERROR"),
            );
          } else if (snap.hasData) {
            return Row(
              children: List.generate(snap.data!.length, (index) {
                Course course = snap.data![index];
                return TextButton(
                    style: TextButton.styleFrom(
                        primary: _courseId == course.id
                            ? ConstColors.tealBlue
                            : ConstColors.amber),
                    onPressed: () {
                      setState(() {
                        _courseId = course.id;
                      });
                    },
                    child: SetTextWidget(
                      course.name,
                      textColor: ConstColors.amber,
                    ));
              }),
            );
          }

          return const Center(
            child: CupertinoActivityIndicator(),
          );
        });
  }

  InputDecoration _setInputDecoration(String hint) => InputDecoration(
        hintText: hint,
      );

  void _onAddButtonPressed() async {
    String id = _uuid.v4();
    String title = _titleController.text;
    String description = _descriptionController.text;
    String imageUrl = _videoUrlController.text;

    if (_courseId!.isEmpty ||
        title.isEmpty ||
        description.isEmpty ||
        imageUrl.isEmpty) {
      Fluttertoast.showToast(msg: "Please, fill all fields");
      return;
    }
    VideoModel videoModel = VideoModel(
      id,
      title,
      description,
      imageUrl,
      0,
      DateTime.now(),
      _courseId,
    );

    await _fireStore
        .collection("Videos")
        .doc(id)
        .set(videoModel.toMap())
        .whenComplete(() {
      Fluttertoast.showToast(msg: "Added");

      _courseId = "";
      _videoUrlController.clear();
      _titleController.clear();
      _descriptionController.clear();
    });
  }

  Future<List<Course>> _getCaourseList() async {
    QuerySnapshot courses =
        await _fireStore.collection('VideoLessonCourseList').get();

    return courses.docs
        .map((e) => Course.fromJson({
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
}
