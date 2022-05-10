import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrains/app/bloc/terrain_cubit.dart';
import 'package:terrains/domain/entities/player.dart';
import 'package:terrains/domain/entities/terrain.dart';
import 'package:terrains/grid.dart';

class TerrainGame extends StatefulWidget {
  final Function onPlayed;
  final TerrainPlayer currentPlayer;

  const TerrainGame(
      {Key? key, required this.onPlayed, required this.currentPlayer})
      : super(key: key);

  @override
  State<TerrainGame> createState() => _TerrainGameState();
}

class _TerrainGameState extends State<TerrainGame> {
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
                type: widget.currentPlayer.type,
              ));
              widget.onPlayed();
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
