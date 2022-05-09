import 'package:terrains/domain/entities/player.dart';

class TerrainRules {
  static final players = <TerrainPlayer>[
    TerrainPlayer.jungle(),
    TerrainPlayer.sea(),
    TerrainPlayer.volcano(),
  ];
}
