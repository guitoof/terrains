import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrains/app/bloc/game_cubit.dart';
import 'package:terrains/domain/entities/terrain.dart';
import 'package:terrains/game.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class TerrainsApp extends StatefulWidget {
  const TerrainsApp({Key? key}) : super(key: key);

  @override
  State<TerrainsApp> createState() => _TerrainsAppState();
}

class _TerrainsAppState extends State<TerrainsApp> {
  final GameCubit gameCubit = GameCubit();

  void _startGame() async {
    setState(() {
      gameCubit.startGame();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      bloc: gameCubit,
      builder: (context, state) {
        return MaterialApp(
          title: 'Terrains',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: state.currentPlayer?.type.color ?? Colors.black,
              titleTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          home: Scaffold(
            appBar: AppBar(title: const Text('Terrains')),
            body: state.status == GameStatus.started
                ? const TerrainGame()
                : Center(
                    child: ElevatedButton(
                      onPressed: _startGame,
                      child: const Text("Start game"),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
