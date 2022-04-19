import 'package:flutter/material.dart';
import 'package:terrains/domain/entities/player.dart';
import 'package:terrains/grid.dart';

class TerrainGame extends StatefulWidget {
  final int gridWidth = 10;
  final int gridHeight = 19;

  const TerrainGame({Key? key}) : super(key: key);

  @override
  State<TerrainGame> createState() => _TerrainGameState();
}

class _TerrainGameState extends State<TerrainGame> {
  final _players = [
    TerrainPlayer.sea(),
    TerrainPlayer.jungle(),
    TerrainPlayer.volcano()
  ];
  int _currentPlayerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return TerrainGrid(
        width: widget.gridWidth,
        height: widget.gridHeight,
        currentPlayer: _players[_currentPlayerIndex],
        onCellTapped: () {
          setState(() {
            _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
          });
        });
  }
}
