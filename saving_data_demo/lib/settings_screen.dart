import 'package:flutter/material.dart';
import 'package:saving_data_demo/sp_helper.dart';

// import 'secure_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _listName = '';
  int _calories = 0;
  bool _showFileSize = false;

  final _listNameController = TextEditingController();
  final _caloriesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future _loadSettings() async {
    final prefs = await SPHelper.getInstance();
    _listName = prefs.getListName();
    _calories = prefs.getCalories();
    _showFileSize = prefs.getShowFileSize();

    setState(() {});

    _listNameController.text = _listName;
    _caloriesController.text = _calories.toString();

    // final secure = await SecureHelper.getInstance();
    // _listName = await secure.getListName();
    // _calories = await secure.getCalories();
    // _showFileSize = await secure.getShowFileSize();

    // setState(() {});

    // _listNameController.text = _listName;
    // _caloriesController.text = _calories.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveSettings,
        child: const Icon(Icons.save),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _listNameController,
              decoration: const InputDecoration(
                labelText: 'List Name',
              ),
              onChanged: (value) {
                setState(() {
                  _listName = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Maximum Daily Calories',
              ),
              onChanged: (value) {
                setState(() {
                  _calories = int.tryParse(value) ?? 0;
                });
              },
            ),
          ),
          SwitchListTile.adaptive(
            title: const Text('Show File Size'),
            value: _showFileSize,
            onChanged: (value) {
              setState(() {
                _showFileSize = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Future _saveSettings() async {
    final prefs = await SPHelper.getInstance();
    await prefs.setListName(_listNameController.text);
    await prefs.setCalories(int.tryParse(_caloriesController.text) ?? 0);
    await prefs.setShowFileSize(_showFileSize);

    // final prefs = await SecureHelper.getInstance();
    // await prefs.setListName(_listNameController.text);
    // await prefs.setCalories(int.tryParse(_caloriesController.text) ?? 0);
    // await prefs.setShowFileSize(_showFileSize);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Settings saved!')));
  }
}
