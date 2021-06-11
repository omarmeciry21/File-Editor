import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<bool> updateFile(String path, String finalContent) async {
  try {
    final file = File(path);

    // Write the file
    await file.writeAsString('$finalContent');
    return true;
  } catch (e) {
    // If encountering an error, return 0
    return false;
  }
}

Future<String> readFile(String path) async {
  try {
    final file = File(path);

    // Read the file
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return '';
  }
}
