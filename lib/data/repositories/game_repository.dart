import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:terrains/database.dart';
import 'package:terrains/domain/entities/player.dart';
import 'package:terrains/domain/entities/terrain.dart';

class GameRepository {
  Future<void> createGame() async {
    DatabaseReference ref = getDatabaseFromApp().ref('terrains');
    return ref.set([]);
  }

  Future<List<TerrainPlayer>> getRegisteredPlayers() async {
    DatabaseReference ref = getDatabaseFromApp().ref('players');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      return List<TerrainPlayer>.from(
        (snapshot.value as List<dynamic>).map((playerData) =>
            TerrainPlayer.fromTerrainType(TerrainType.values.firstWhere(
              (t) => playerData['type'] == t.toString(),
            ))),
      );
    }
    return [];
  }

  Future<void> addPlayer(TerrainPlayer player) async {
    DatabaseReference ref = getDatabaseFromApp().ref('players');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final registeredPlayers = snapshot.value as List<dynamic>;
      await ref.set([...registeredPlayers, player.toJson()]);
    } else {
      await ref.set([player.toJson()]);
    }
  }

  Future<TerrainPlayer?> getCurrentPlayer() async {
    DatabaseReference ref = getDatabaseFromApp().ref('currentPlayer');
    final snapshot = await ref.get();
    if (!snapshot.exists) return null;

    final Map<String, dynamic> playerData =
        json.decode(json.encode(snapshot.value));
    return TerrainPlayer.fromTerrainType(
      TerrainType.values.firstWhere((t) => playerData['type'] == t.toString()),
    );
  }

  void setCurrentPlayer(TerrainPlayer player) async {
    DatabaseReference ref = getDatabaseFromApp().ref('currentPlayer');
    await ref.set(player.toJson());
  }

  void addTerrain(Terrain terrain) async {
    DatabaseReference ref = getDatabaseFromApp().ref('terrains');
    await ref.update({terrain.key: terrain.toJson()});
  }

  void listenToTerrains(void Function(dynamic data) onGameUpdated) {
    DatabaseReference ref = getDatabaseFromApp().ref('terrains');
    ref.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        onGameUpdated.call(event.snapshot.value);
      }
    });
  }
}
