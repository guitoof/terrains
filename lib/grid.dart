import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:terrains/cell.dart';
import 'package:terrains/domain/entities/terrain.dart';

class TerrainGrid extends StatelessWidget {
  late final int width;
  late final int height;
  final List<List<Terrain?>> data;
  final Function(Point<int> position) onCellAtPositionTapped;

  TerrainGrid({
    Key? key,
    required this.data,
    required this.onCellAtPositionTapped,
  }) : super(key: key) {
    height = data.length;
    width = data.isEmpty ? 0 : data[0].length;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: width.toInt(),
      children: data.flattened.mapIndexed(
        (index, cell) {
          final x = index % width;
          final y = index ~/ width;
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade300),
            ),
            child: TerrainCell(
                key: ValueKey('$x-$y'),
                terrain: cell,
                onTap: () {
                  onCellAtPositionTapped(Point<int>(x, y));
                }),
          );
        },
      ).toList(),
    );
  }
}
