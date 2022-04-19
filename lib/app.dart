import 'package:flutter/material.dart';
import 'package:terrains/grid.dart';

class TerrainsApp extends StatelessWidget {
  const TerrainsApp({Key? key}) : super(key: key);

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
        appBar: AppBar(
          title: const Text('Terrains'),
        ),
        body: const Grid(),
      ),
    );
  }
}
