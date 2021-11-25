import 'package:courses/components/exporting_packages.dart';

abstract class CategoryService {
  Future addCategory(Map<String, dynamic> map);

  Future<List<Category>> getAllCategories();
}

class CategoryMethods extends CategoryService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future addCategory(Map<String, dynamic> map) async {
   await _fireStore.collection('VideoLessonCategories').doc(map['id']).set(map);
  }

  @override
  Future<List<Category>> getAllCategories() {
    // TODO: implement getAllCategories
    throw UnimplementedError();
  }
}
