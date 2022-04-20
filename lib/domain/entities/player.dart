import 'package:terrains/domain/entities/terrain.dart';

class TerrainPlayer {
  final Terrain terrain;

  TerrainPlayer({required this.terrain});

  factory TerrainPlayer.sea() => TerrainPlayer(terrain: Terrain.sea());

  factory TerrainPlayer.volcano() => TerrainPlayer(terrain: Terrain.volcano());

  factory TerrainPlayer.jungle() => TerrainPlayer(terrain: Terrain.jungle());
}
