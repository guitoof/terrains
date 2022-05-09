import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrains/data/repositories/game_repository.dart';
import 'package:terrains/domain/entities/player.dart';
import 'package:terrains/domain/entities/rules.dart';

enum GameState { notStarted, started }

class GameCubit extends Cubit<GameState> {
  final GameRepository _gameRepository = GameRepository();

  GameCubit() : super(GameState.notStarted);

  static TerrainPlayer? _pickRandomPlayer(
      {List<TerrainPlayer> exclude = const []}) {
    if (exclude.length >= TerrainRules.players.length) return null;
    final randomIndex =
        Random().nextInt(TerrainRules.players.length - exclude.length);
    return TerrainRules.players
        .where((player) => !exclude.contains(player))
        .elementAt(randomIndex);
  }

  Future<void> startGame() async {
    final registeredPlayers = await _gameRepository.getRegisteredPlayers();
    final player = GameCubit._pickRandomPlayer(exclude: registeredPlayers);
    if (player != null) {
      return _gameRepository.addPlayer(player);
    }
  }
}
