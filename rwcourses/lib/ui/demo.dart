import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: MyHomePage(isLoading: false, counter: 1),
      ),
    ),
  ));
}

class MyHomePage extends StatefulWidget {
  final bool isLoading;
  final int counter;

  const MyHomePage({required this.isLoading, required this.counter});

  @override
  State<MyHomePage> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  late bool _isLoading;
  late int _counter;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
    _counter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuild MyHomePage');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: MyCenterWidget(isLoading: _isLoading, counter: _counter),
      floatingActionButton: FloatingActionButton(
        onPressed: onFloatingButtonClicked,
      ),
    );
  }

  void onFloatingButtonClicked() {
    print('Button clicked!. Call setState method');
    setState(() {
      _counter++;
      if (_counter.isEven) {
        _isLoading = false;
      } else {
        _isLoading = true;
      }
    });
  }
}

class MyCenterWidget extends StatelessWidget {
  const MyCenterWidget({
    super.key,
    required this.isLoading,
    required this.counter,
  });

  final bool isLoading;
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CounterWidget(
        isLoading: isLoading,
        counter: counter,
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final bool isLoading;
  final int counter;

  const CounterWidget({required this.isLoading, required this.counter});

  @override
  Widget build(BuildContext context) {
    print('Rebuild CounterWidget');
    return isLoading ? CircularProgressIndicator() : Text('Counter: $counter');
  }
}
