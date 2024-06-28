import 'package:flutter/material.dart';

import 'file_helper.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({super.key, this.fileName});

  final String? fileName;

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  final _fileNameController = TextEditingController();
  final _dataController = TextEditingController();
  final _fileHelper = FileHelper();

  @override
  void initState() {
    super.initState();
    if (widget.fileName != null) {
      _fileNameController.text = widget.fileName!;
      _readFile();
    }
  }

  Future<void> _readFile() async {
    final data = await _fileHelper.readFromFile(widget.fileName!);
    setState(() {
      _dataController.text = data;
      _showMessage('File loaded');
    });
  }

  Future<void> _writeFile() async {
    await _fileHelper.writeToFile(
      _fileNameController.text,
      _dataController.text,
    );
    setState(() {
      _showMessage('File saved');
    });
  }

  Future<void> _deleteFile() async {
    await _fileHelper.deleteFile(_fileNameController.text);
    setState(() {
      _dataController.clear();
      _showMessage('File deleted');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName ?? 'New File'),
        actions: [
          if (widget.fileName != null)
            IconButton(
              onPressed: () {
                _deleteFile().then((value) => Navigator.pop(context));
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _writeFile,
        child: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _fileNameController,
              decoration: const InputDecoration(labelText: 'File Name'),
            ),
            TextField(
              controller: _dataController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
