import 'package:flutter/material.dart';
import 'package:rwcourses/strings.dart';
import 'package:rwcourses/ui/filter/filter_page.dart';

import 'ui/courses/courses_page.dart';

class RWCoursesApp extends StatelessWidget {
  const RWCoursesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appTitle),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const FilterPage();
                },
              ));
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: const CoursesPage(),
    );
  }
}
