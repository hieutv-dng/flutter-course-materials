import 'package:flutter/material.dart';
import 'package:rwcourses/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/domain.dart';

class FilterStateContainer extends StatefulWidget {
  const FilterStateContainer({super.key, required this.child});

  final Widget child;

  @override
  State<FilterStateContainer> createState() => FilterState();

  static FilterState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_FilterInheritedWidget>()!
        .state;
  }
}

class FilterState extends State<FilterStateContainer> {
  int filterValue = Domain.all.value;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  void _loadValue() {
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
      setState(() {
        filterValue = _prefs.getInt(Constants.filterKey) ?? Domain.all.value;
      });
    });
  }

  void updateFilterValue(int value) {
    setState(() {
      filterValue = value;
      _prefs.setInt(Constants.filterKey, filterValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _FilterInheritedWidget(
      state: this,
      child: widget.child,
    );
  }
}

class _FilterInheritedWidget extends InheritedWidget {
  final FilterState state;

  const _FilterInheritedWidget({
    super.key,
    required super.child,
    required this.state,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
