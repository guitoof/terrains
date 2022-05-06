import 'package:firebase_database/firebase_database.dart';
import 'package:terrains/database.dart';
import 'package:terrains/domain/entities/terrain.dart';
import 'package:terrains/domain/entities/terrains_game.dart';

class GameRepository {
  void startGame(TerrainsGame game) async {
    DatabaseReference ref = getDatabaseFromApp().ref();
    await ref.set({...game.toMap()});
  }

  void addTerrain(Terrain terrain) async {
    DatabaseReference ref = getDatabaseFromApp().ref();
    await ref.update({'terrains/${terrain.key}': terrain.toJson()});
  }

  void listenToGame(void Function(Object? data) onGameUpdated) {
    DatabaseReference ref = getDatabaseFromApp().ref();
    ref.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        onGameUpdated.call(event.snapshot.value);
      }
    });
  }
}
