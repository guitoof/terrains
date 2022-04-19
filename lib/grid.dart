import 'package:flutter/material.dart';
import 'package:terrains/cell.dart';

class Grid extends StatelessWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 10,
      children: List.generate(
        10 * 19,
        (index) => Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.shade300),
          ),
          child: const TerrainCell(),
        ),
      ),
    );
  }
}
