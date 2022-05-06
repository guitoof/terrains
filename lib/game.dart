import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrains/app/bloc/terrain_cubit.dart';
import 'package:terrains/domain/entities/player.dart';
import 'package:terrains/domain/entities/terrain.dart';
import 'package:terrains/grid.dart';

const int gridWidth = 10;
const int gridHeight = 19;

class TerrainGame extends StatefulWidget {
  final TerrainCubit terrainCubit;

  const TerrainGame({Key? key, required this.terrainCubit}) : super(key: key);

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

  _nextPlayer() {
    setState(() {
      _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.terrainCubit,
      child: TerrainGrid(
          data: widget.terrainCubit.state,
          onCellAtPositionTapped: (location) {
            try {
              widget.terrainCubit.addTerrain(Terrain(
                location: location,
                type: _players[_currentPlayerIndex].terrain.type,
              ));
              _nextPlayer();
            } catch (error) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      AlertDialog(title: Text(error.toString())));
            }
          }),
    );
  }
}
