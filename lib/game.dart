import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrains/app/bloc/terrain_cubit.dart';
import 'package:terrains/domain/entities/player.dart';
import 'package:terrains/domain/entities/terrain.dart';
import 'package:terrains/grid.dart';

class TerrainGame extends StatefulWidget {
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

  _nextPlayer() {
    setState(() {
      _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final terrainCubit = TerrainCubit(10, 20);
    return BlocBuilder<TerrainCubit, List<List<Terrain?>>>(
      bloc: terrainCubit,
      builder: (context, state) => TerrainGrid(
          data: state,
          onCellAtPositionTapped: (location) {
            try {
              terrainCubit.addTerrain(Terrain(
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
