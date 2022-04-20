import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrains/domain/entities/terrain.dart';

class TerrainCubit extends Cubit<List<List<Terrain?>>> {
  final differentNeighbouringTerrainsLimit = 2;

  TerrainCubit(int width, int height)
      : super(
          List.generate(height, (_) => List.generate(width, (_) => null)),
        );

  bool _isNeighbourTerrainDifferent(
      Terrain terrain, Terrain? neighbourTerrain) {
    if (neighbourTerrain == null) return false;
    return terrain.color != neighbourTerrain.color;
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
    final newTerrainGrid = state;
    newTerrainGrid[terrain.location!.y][terrain.location!.x] = terrain;
    emit(newTerrainGrid);
  }
}
