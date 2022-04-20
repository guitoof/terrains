import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrains/domain/entities/terrain.dart';

class TerrainCubit extends Cubit<List<List<Terrain?>>> {
  TerrainCubit(int width, int height)
      : super(
          List.generate(height, (_) => List.generate(width, (_) => null)),
        );

  void addTerrain(Terrain terrain) {
    assert(terrain.location != null);
    final newTerrainGrid = state;
    newTerrainGrid[terrain.location!.y][terrain.location!.x] = terrain;
    emit(newTerrainGrid);
  }
}
