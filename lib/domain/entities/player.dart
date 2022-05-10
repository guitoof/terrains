import 'package:terrains/domain/entities/terrain.dart';

class TerrainPlayer {
  final Terrain terrain;

  TerrainPlayer({required this.terrain});

  TerrainType get type => terrain.type;

  factory TerrainPlayer.sea() => TerrainPlayer(terrain: Terrain.sea());

  factory TerrainPlayer.volcano() => TerrainPlayer(terrain: Terrain.volcano());

  factory TerrainPlayer.jungle() => TerrainPlayer(terrain: Terrain.jungle());

  factory TerrainPlayer.fromTerrainType(TerrainType type) {
    return TerrainPlayer(terrain: Terrain(type: type));
  }

  Map<String, dynamic> toJson() => {'type': type.toString()};

  @override
  operator ==(other) => other is TerrainPlayer && other.type == type;

  @override
  int get hashCode => type.hashCode;
}
