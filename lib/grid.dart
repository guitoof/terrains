import 'package:flutter/material.dart';
import 'package:terrains/cell.dart';
import 'package:terrains/domain/entities/player.dart';

class TerrainGrid extends StatelessWidget {
  final int width;
  final int height;
  final TerrainPlayer currentPlayer;
  final VoidCallback onCellTapped;

  const TerrainGrid({
    Key? key,
    required this.width,
    required this.height,
    required this.currentPlayer,
    required this.onCellTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: width.toInt(),
      children: List.generate(
        (width * height).toInt(),
        (index) => Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.shade300),
          ),
          child: TerrainCell(currentPlayer: currentPlayer, onTap: onCellTapped),
        ),
      ),
    );
  }
}
