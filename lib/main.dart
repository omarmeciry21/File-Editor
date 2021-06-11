import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'file_manager.dart' as file_manager;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController fileNameController = TextEditingController();
    final TextEditingController fileContentController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          title: Text('File Editor'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: fileNameController,
                  decoration: InputDecoration(labelText: 'File Name'),
                ),
                TextField(
                  controller: fileContentController,
                  decoration: InputDecoration(labelText: 'File Content'),
                  maxLines: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            final path = await file_manager.localPath;
                            file_manager.updateFile(
                                '$path/${fileNameController.text}.txt',
                                fileContentController.text);
                            Fluttertoast.showToast(msg: 'Saved Successfully!');
                            fileContentController.clear();
                          },
                          child: Text('Save'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            final path = await file_manager.localPath;
                            fileContentController.text =
                                await file_manager.readFile(
                                    '$path/${fileNameController.text}.txt');
                            Fluttertoast.showToast(msg: 'Read Successfully!');
                          },
                          child: Text('Read'),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
