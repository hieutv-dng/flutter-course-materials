import 'package:flutter/material.dart';
import 'package:rwcourses/model/course.dart';
import 'package:rwcourses/ui/course_detail/image_container.dart';
import 'package:rwcourses/utils/string_extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),
            _buildMain(context),
            _buildDetails(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: () => _launchCourse(course.courseId),
                child: const Text('Xem khoá học'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Hero(
      tag: 'cardArtwork-${course.courseId}',
      transitionOnUserGestures: true,
      child: ImageContainer(
        height: 200,
        url: course.artworkUrl ?? '',
      ),
    );
  }

  Widget _buildMain(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            course.description ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.domainsString,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Level: ${course.difficulty?.capitalize()}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '${course.contributors}',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _launchCourse(String courseId) {
    launchUrlString(
      'https://raywenderlich.com/$courseId',
      mode: LaunchMode.platformDefault,
    );
  }
}
