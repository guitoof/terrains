import 'package:flutter/material.dart';

class TerrainPlayer {
  final Color color;

  TerrainPlayer({required this.color});

  factory TerrainPlayer.sea() => TerrainPlayer(color: Colors.blue);

  factory TerrainPlayer.volcano() => TerrainPlayer(color: Colors.red);

  factory TerrainPlayer.jungle() => TerrainPlayer(color: Colors.green);
}
