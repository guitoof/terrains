import 'package:flutter/material.dart';

class TerrainCell extends StatefulWidget {
  const TerrainCell({Key? key}) : super(key: key);

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
          _color = Colors.black;
        });
      },
      child: Container(
        color: _color,
      ),
    );
  }
}
