import 'dart:math';

import 'package:flutter/material.dart';

enum TerrainType {
  sea,
  jungle,
  volcano,
}

extension TerrainTypeExtension on TerrainType {
  Color get color {
    switch (this) {
      case TerrainType.sea:
        return Colors.blue;
      case TerrainType.jungle:
        return Colors.green;
      case TerrainType.volcano:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

class Terrain {
  final TerrainType type;
  final Point<int>? location;

  Terrain({required this.type, this.location});

  factory Terrain.sea() => Terrain(type: TerrainType.sea);

  factory Terrain.volcano() => Terrain(type: TerrainType.volcano);

  factory Terrain.jungle() => Terrain(type: TerrainType.jungle);

  String get key => '${location!.x}-${location!.y}';

  Map<String, dynamic> toJson() => {
        'type': type.toString(),
        'location': {'x': location!.x, 'y': location!.y}
      };
}
