import 'package:flutter/material.dart';
import 'package:rwcourses/repository/course_repository.dart';
import 'package:rwcourses/ui/course_detail/course_detail_page.dart';

import '../../model/course.dart';
import '../../states/filter_state_container.dart';
import 'courses_controller.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final _controller = CoursesController(CourseRepository());
  late FilterState state;

  @override
  void didUpdateWidget(covariant CoursesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = FilterStateContainer.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _controller.fetchCourses(state.filterValue),
      builder: (context, snapshot) {
        final courses = snapshot.data;
        if (courses == null ||
            (snapshot.connectionState != ConnectionState.done)) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return _buildRow(courses[index]);
          },
        );
      },
    );
  }

  Widget _buildRow(Course course) {
    return ListTile(
      title: Text(
        course.name,
        style: const TextStyle(fontSize: 18.0),
      ),
      trailing: Hero(
        tag: 'cardArtwork-${course.courseId}',
        transitionOnUserGestures: true,
        child: course.artworkUrl != null
            ? Image.network(course.artworkUrl!)
            : const SizedBox(),
      ),
      subtitle: Text(course.domainsString),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return CourseDetailPage(course: course);
          },
        ));
      },
    );
  }
}
