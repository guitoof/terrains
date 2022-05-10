import 'package:flutter/material.dart';
import 'package:terrains/domain/entities/terrain.dart';

class TerrainCell extends StatelessWidget {
  final Terrain? terrain;
  final VoidCallback onTap;

  const TerrainCell({Key? key, required this.terrain, required this.onTap})
      : super(key: key);

  bool get isBlank => terrain == null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isBlank) {
          showDialog(
              context: context,
              builder: (context) =>
                  const AlertDialog(title: Text('Terrain is taken !')));
        } else {
          onTap();
        }
      },
      child: Container(
        color: terrain != null ? terrain!.type.color : Colors.white,
      ),
    );
  }
}
