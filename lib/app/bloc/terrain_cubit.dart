import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrains/data/repositories/game_repository.dart';
import 'package:terrains/domain/entities/terrain.dart';

class TerrainCubit extends Cubit<List<List<Terrain?>>> {
  final GameRepository _gameRepository = GameRepository();
  final differentNeighbouringTerrainsLimit = 2;

  TerrainCubit(int width, int height)
      : super(
          List.generate(height, (_) => List.generate(width, (_) => null)),
        ) {
    _gameRepository.listenToGame((data) {
      final newTerrainGrid = state;
      if (data is! Map) {
        return;
      }
      final lastTerrainData = data['terrains'].entries.last;
      final Terrain lastTerrain = Terrain(
        type: TerrainType.values
            .firstWhere((t) => lastTerrainData.value['type'] == t.toString()),
        location: Point(
          lastTerrainData.value['location']['x'],
          lastTerrainData.value['location']['y'],
        ),
      );
      newTerrainGrid[lastTerrain.location!.y][lastTerrain.location!.x] =
          lastTerrain;
      emit(newTerrainGrid);
    });
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
    final newTerrainGrid = state;
    newTerrainGrid[terrain.location!.y][terrain.location!.x] = terrain;
    emit(newTerrainGrid);
  }
}
