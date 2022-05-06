import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:terrains/app/bloc/game_cubit.dart';
import 'package:terrains/app/bloc/terrain_cubit.dart';
import 'package:terrains/database.dart';
import 'package:terrains/game.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class TerrainsApp extends StatefulWidget {
  const TerrainsApp({Key? key}) : super(key: key);

  @override
  State<TerrainsApp> createState() => _TerrainsAppState();
}

class _TerrainsAppState extends State<TerrainsApp> {
  TerrainCubit? _terrainCubit;

  void _startGame() async {
    setState(() {
      _terrainCubit = TerrainCubit(10, 20);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terrains',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Terrains')),
        body: _terrainCubit != null
            ? TerrainGame(terrainCubit: _terrainCubit!)
            : Center(
                child: ElevatedButton(
                    onPressed: _startGame, child: const Text("Start game"))),
      ),
    );
  }
}
