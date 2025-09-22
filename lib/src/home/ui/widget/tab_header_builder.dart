import 'package:flutter/material.dart';

class TabHeaderBuilder extends StatelessWidget {
  const TabHeaderBuilder({
    super.key,
    required this.name,
    required this.tabIndex,
    required this.selected,
  });
  final String name;
  final int tabIndex, selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 90,
      // constraints: BoxConstraints(maxHeight: 35, maxWidth: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: tabIndex == selected ? Colors.green : Colors.black,
        ),
      ),

      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
