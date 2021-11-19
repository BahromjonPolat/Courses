import 'package:courses/models/course_model.dart';

class VideoModel {
  String? _id;
  String? _title;
  String? _description;
  String? _videoUrl;
  String? _courseId;
  int? _duration;
  DateTime? _uploadedDate;

  VideoModel(
    this._id,
    this._title,
    this._description,
    this._videoUrl,
    this._duration,
    this._uploadedDate,
    this._courseId,
  );

  VideoModel.fromJson(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _uploadedDate = map['uploadedDate'];
    _videoUrl = map['videoUrl'];
    _duration = map['duration'];
    _courseId = map['courseId'];
  }

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'description': _description,
        'videoUrl': _videoUrl,
        'duration': _duration,
        'uploadedDate': _uploadedDate,
        'courseId': _courseId,
      };

  DateTime get uploadedDate => _uploadedDate!;

  int get duration => _duration!;

  String get videoUrl => _videoUrl!;

  String get description => _description!;

  String get title => _title!;

  String get id => _id!;
}
