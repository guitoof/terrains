import 'dart:math';

import 'package:flutter/material.dart';

class Terrain {
  final Color color;
  final Point<int>? location;

  Terrain({required this.color, this.location});

  factory Terrain.sea() => Terrain(color: Colors.blue);

  factory Terrain.volcano() => Terrain(color: Colors.red);

  factory Terrain.jungle() => Terrain(color: Colors.green);
}
