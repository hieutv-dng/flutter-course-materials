import 'package:flutter/material.dart';
import 'package:rwcourses/rwcourses_app.dart';
import 'package:rwcourses/strings.dart';
import 'package:rwcourses/states/filter_state_container.dart';

void main() {
  runApp(
    FilterStateContainer(
      child: MaterialApp(
        title: Strings.appTitle,
        theme: ThemeData(
          primaryColor: Colors.green.shade800,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green.shade800,
            // foregroundColor: Colors.white,
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            actionsIconTheme: const IconThemeData(color: Colors.white),
          ),
          actionIconTheme: ActionIconThemeData(
            backButtonIconBuilder: (context) {
              return const Icon(
                Icons.arrow_back,
                color: Colors.white,
              );
            },
          ),
        ),
        home: const RWCoursesApp(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
