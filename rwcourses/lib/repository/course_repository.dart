import 'dart:convert';
import 'package:rwcourses/model/course.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'repository.dart';

class CourseRepository implements Repository {
  final dataUrl =
      'https://api.raywenderlich.com/api/contents?filter[content_types][]=collection';

  @override
  Future<List<Course>> getCourses(int domainFilter) async {
    final courses = <Course>[];
    var url = dataUrl;

    if (domainFilter != Constants.allFilter) {
      url += '&filter[domain_ids][]=$domainFilter';
    }

    final uri = Uri.parse(url);

    http
        .get(uri)
        .then((value) {})
        .whenComplete(() {})
        .catchError((exception) {});

    final response = await http.get(uri);
    final apiResponse = json.decode(response.body) as Map<String, dynamic>;
    final data = apiResponse['data'] as List;
    for (final json in data) {
      courses.add(Course.fromJson(json));
    }

    return courses;
  }
}
