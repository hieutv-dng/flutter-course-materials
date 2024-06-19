import 'package:rwcourses/model/course.dart';
import 'repository.dart';

class MockupRepository implements Repository {
  @override
  Future<List<Course>> getCourses(int domainFilter) async {
    final courses = <Course>[];

    courses.addAll([
      Course(
          '1', 'Demo', 'Test', 'artworkUrl', 'difficulty', 'contributors', []),
      Course(
          '1', 'Demo', 'Test', 'artworkUrl', 'difficulty', 'contributors', []),
      Course(
          '1', 'Demo', 'Test', 'artworkUrl', 'difficulty', 'contributors', []),
      Course(
          '1', 'Demo', 'Test', 'artworkUrl', 'difficulty', 'contributors', []),
    ]);

    return courses;
  }
}
