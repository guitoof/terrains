import 'package:flutter/material.dart';
import 'package:terrains/game.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class TerrainsApp extends StatefulWidget {
  const TerrainsApp({Key? key}) : super(key: key);

  @override
  State<TerrainsApp> createState() => _TerrainsAppState();
}

class _TerrainsAppState extends State<TerrainsApp> {
  bool _isGameStarted = false;

  void _startGame() async {
    setState(() {
      _isGameStarted = true;
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
        body: _isGameStarted
            ? const TerrainGame()
            : Center(
                child: ElevatedButton(
                  onPressed: _startGame,
                  child: const Text("Start game"),
                ),
              ),
      ),
    );
  }
}
