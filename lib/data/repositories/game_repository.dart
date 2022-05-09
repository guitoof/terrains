import 'package:firebase_database/firebase_database.dart';
import 'package:terrains/database.dart';
import 'package:terrains/domain/entities/player.dart';
import 'package:terrains/domain/entities/terrain.dart';
import 'package:terrains/domain/entities/terrains_game.dart';

class GameRepository {
  void startGame(TerrainsGame game) async {
    DatabaseReference ref = getDatabaseFromApp().ref();
    await ref.set({...game.toMap()});
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

  void addPlayer(TerrainPlayer player) async {
    DatabaseReference ref = getDatabaseFromApp().ref('players');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final registeredPlayers = snapshot.value as List<dynamic>;
      await ref.set([...registeredPlayers, player.toJson()]);
    } else {
      await ref.set([player.toJson()]);
    }
  }

  void addTerrain(Terrain terrain) async {
    DatabaseReference ref = getDatabaseFromApp().ref();
    await ref.update({'terrains/${terrain.key}': terrain.toJson()});
  }

  void listenToGame(void Function(dynamic data) onGameUpdated) {
    DatabaseReference ref = getDatabaseFromApp().ref();
    ref.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        onGameUpdated.call(event.snapshot.value);
      }
    });
  }
}
