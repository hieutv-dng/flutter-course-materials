import 'package:flutter/material.dart';
import 'package:rwcourses/model/domain.dart';
import 'package:rwcourses/states/filter_state_container.dart';
import '../../constants.dart';
import 'filter_widget.dart';

import '../../strings.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late FilterState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.filter),
      ),
      body: Column(
        children: Domain.filters.map(
          (e) {
            return FilterWidget(
              value: e.value,
              groupValue: state.filterValue,
              onChanged: _handleRadioValueChange,
              text: e.name,
            );
          },
        ).toList(),
        // children: [
        //   FilterWidget(
        //     value: Constants.iosFilter,
        //     groupValue: _filterValue,
        //     onChanged: _handleRadioValueChange,
        //     text: Strings.ios,
        //   ),
        //   FilterWidget(
        //     value: Constants.androidFilter,
        //     groupValue: _filterValue,
        //     onChanged: _handleRadioValueChange,
        //     text: Strings.android,
        //   ),
        //   FilterWidget(
        //     value: Constants.flutterFilter,
        //     groupValue: _filterValue,
        //     onChanged: _handleRadioValueChange,
        //     text: Strings.flutter,
        //   ),
        //   FilterWidget(
        //     value: Constants.sssFilter,
        //     groupValue: _filterValue,
        //     onChanged: _handleRadioValueChange,
        //     text: Strings.sss,
        //   ),
        //   FilterWidget(
        //     value: Constants.unityFilter,
        //     groupValue: _filterValue,
        //     onChanged: _handleRadioValueChange,
        //     text: Strings.unity,
        //   ),
        //   FilterWidget(
        //     value: Constants.macosFilter,
        //     groupValue: _filterValue,
        //     onChanged: _handleRadioValueChange,
        //     text: Strings.macos,
        //   ),
        //   FilterWidget(
        //     value: Constants.allFilter,
        //     groupValue: _filterValue,
        //     onChanged: _handleRadioValueChange,
        //     text: Strings.all,
        //   ),
        // ],
      ),
    );
  }

  void _handleRadioValueChange(int? value) {
    state.updateFilterValue(value ?? Constants.allFilter);
  }
}
