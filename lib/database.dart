import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase getDatabaseFromApp() => FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          'https://terrains-game-default-rtdb.europe-west1.firebasedatabase.app/',
    );
