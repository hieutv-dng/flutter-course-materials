import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saving_data_demo/file_helper.dart';
import 'package:saving_data_demo/settings_screen.dart';

import 'file_screen.dart';
import 'sp_helper.dart';

class FileListScreen extends StatefulWidget {
  const FileListScreen({super.key});

  @override
  State<FileListScreen> createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  String _listName = '';
  bool _showFileSize = false;

  @override
  void initState() {
    super.initState();
    _getSettings();
  }

  Future<void> _getSettings() async {
    final spHelper = await SPHelper.getInstance();
    setState(() {
      _listName = spHelper.getListName();
      _showFileSize = spHelper.getShowFileSize();
    });
  }

  Future<List<File>> _getFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.listSync().whereType<File>().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_listName),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  )).then((value) {
                _getSettings();
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openFileScreen,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _getFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final files = snapshot.data as List<File>;
          if (files.isEmpty) {
            return const Center(child: Text('No files found'));
          }

          return ListView.builder(
            itemCount: files.length,
            itemBuilder: (context, index) {
              final file = files[index];
              final date = file.lastModifiedSync();
              final dateString = '${date.day}/${date.month}/${date.year}';
              final size = file.lengthSync();
              final fileName = file.path.split('/').last;
              return Dismissible(
                key: ValueKey(fileName),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (direction) {
                  final fileHelper = FileHelper();
                  fileHelper
                      .deleteFile(fileName)
                      .then((value) => setState(() {}));
                },
                child: ListTile(
                  title: Text(fileName),
                  subtitle: _showFileSize
                      ? Text('Size: $size bytes, Last modified: $dateString')
                      : Text('Date: $dateString'),
                  onTap: () => _openFileScreen(fileName: fileName),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _openFileScreen({String? fileName}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FileScreen(fileName: fileName);
    })).then((value) => setState(() {}));
  }
}
