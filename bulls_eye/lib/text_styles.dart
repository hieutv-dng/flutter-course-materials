import 'package:flutter/material.dart';

class LabelTextStyle {
  static TextStyle? bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.black,
          letterSpacing: 2,
        );
  }
}

class ScoreNumberTextStyle {
  static TextStyle? headlineSmall(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        );
  }
}

class TargetNumberTextStyle {
  static TextStyle? bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 32,
          color: Colors.black,
        );
  }
}
