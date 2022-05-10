import 'dart:convert';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrains/data/repositories/game_repository.dart';
import 'package:terrains/domain/entities/terrain.dart';

class TerrainCubit extends Cubit<List<List<Terrain?>>> {
  final GameRepository _gameRepository = GameRepository();
  final differentNeighbouringTerrainsLimit = 2;
  final int width;
  final int height;

  TerrainCubit(this.width, this.height)
      : super(_getInitialState(width, height)) {
    _gameRepository.listenToTerrains(_onTerrainsUpdate);
  }

  static List<List<Terrain?>> _getInitialState(int width, int height) =>
      List.generate(height, (_) => List.generate(width, (_) => null));

  void _onTerrainsUpdate(data) {
    final terrainsData = Map<String, dynamic>.from(data);
    final newState = _getInitialState(width, height);
    terrainsData.forEach((key, value) {
      newState[value['location']['y']][value['location']['x']] =
          Terrain.fromJson(Map<String, dynamic>.from(value));
    });
    emit(newState);
  }

  bool _isNeighbourTerrainDifferent(
      Terrain terrain, Terrain? neighbourTerrain) {
    if (neighbourTerrain == null) return false;
    return terrain.type != neighbourTerrain.type;
  }

  List<Terrain?> _getNeighbours(Terrain terrain) {
    assert(terrain.location != null);
    final x = terrain.location!.x;
    final y = terrain.location!.y;

    return [
      if (y > 0 && x > 0) state[y - 1][x - 1],
      if (y > 0) state[y - 1][x],
      if (y > 0 && x < state[y].length - 1) state[y - 1][x + 1],
      if (x > 0) state[y][x - 1],
      if (x < state[y].length - 1) state[y][x + 1],
      if (y < state.length - 1 && x > 0) state[y + 1][x - 1],
      if (y < state.length - 1) state[y + 1][x],
      if (y < state.length - 1 && x < state[y].length - 1) state[y + 1][x + 1],
    ];
  }

  bool _isTerrainTooManyNearDifferentTerrains(Terrain terrain) {
    assert(terrain.location != null);
    int differentNeighboursCounter = 0;
    final neighbours = _getNeighbours(terrain);
    for (final neighbour in neighbours) {
      if (_isNeighbourTerrainDifferent(terrain, neighbour)) {
        differentNeighboursCounter++;
      }
    }

    return differentNeighboursCounter >= differentNeighbouringTerrainsLimit;
  }

  void addTerrain(Terrain terrain) {
    assert(terrain.location != null);
    if (_isTerrainTooManyNearDifferentTerrains(terrain)) {
      throw Exception(
          'Terrain cannot be placed near more than 2 different terrains');
    }
    _gameRepository.addTerrain(terrain);
  }
}
