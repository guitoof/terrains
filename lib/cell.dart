import 'package:flutter/material.dart';
import 'package:terrains/domain/entities/player.dart';

class TerrainCell extends StatefulWidget {
  final TerrainPlayer currentPlayer;
  final VoidCallback onTap;

  const TerrainCell(
      {Key? key, required this.currentPlayer, required this.onTap})
      : super(key: key);

  @override
  State<TerrainCell> createState() => _TerrainCellState();
}

class _TerrainCellState extends State<TerrainCell> {
  Color _color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _color = widget.currentPlayer.color;
        });
        widget.onTap();
      },
      child: Container(
        color: _color,
      ),
    );
  }
}
