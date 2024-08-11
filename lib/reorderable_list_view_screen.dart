import 'dart:ui';

import 'package:flutter/material.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<String> items = List.generate(50, (index) => 'item ${index + 1}');
  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final Color oddItemColor = Colors.lime.shade100;
    final Color evenItemColor = Colors.deepPurple.shade100;
    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      buildDefaultDragHandles: false,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = items.removeAt(oldIndex);
          items.insert(newIndex, item);
        });
      },
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            final double animValue =
                Curves.easeInOut.transform(animation.value);
            final double scale = lerpDouble(1, 1.02, animValue)!;

            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: child,
        );
      },
      children: List.generate(
        items.length,
        (index) => ReorderableDragStartListener(
          index: index,
          key: Key('$index'),
          child: Card(
            // elevation: lerpDouble(1, 1.02, Curves.easeInOut.transform(0.1))!,
            elevation: 5,
            color: _items[index].isOdd ? oddItemColor : evenItemColor,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: SizedBox(
              height: 120,
              child: ListTile(
                title: Center(
                  child: Text(
                    items[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                leading: const Icon(Icons.drag_indicator_rounded),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 204, 93, 85),
                  ),
                  onPressed: () {
                    setState(() {
                      items.removeAt(index);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
