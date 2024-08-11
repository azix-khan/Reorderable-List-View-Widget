import 'package:flutter/material.dart';
import 'package:reorderable_list_view/reorderable_list_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Reorderable List View widget',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reorderable List View',
            style: TextStyle(
              color: Color.fromARGB(255, 156, 122, 73),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: const ReorderableListViewScreen(),
      ),
    );
  }
}
