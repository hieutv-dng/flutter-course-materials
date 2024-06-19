import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
  });

  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: Text(text),
    );
  }
}
