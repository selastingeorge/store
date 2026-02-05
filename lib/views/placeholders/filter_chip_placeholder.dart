import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FilterChipPlaceholder extends StatelessWidget {
  final int count;
  const FilterChipPlaceholder({super.key, this.count = 5});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(count, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Chip(label: Text("sample")),
            );
          }),
        ),
      ),
    );
  }
}
