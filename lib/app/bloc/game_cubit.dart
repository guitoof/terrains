import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrains/data/repositories/game_repository.dart';
import 'package:terrains/domain/entities/player.dart';
import 'package:terrains/domain/entities/rules.dart';

enum GameStatus { notStarted, started }

class GameState {
  final GameStatus status;

  final TerrainPlayer? localPlayer;
  final TerrainPlayer? currentPlayer;

  GameState(
      {this.status = GameStatus.notStarted,
      this.localPlayer,
      this.currentPlayer});
}

class GameCubit extends Cubit<GameState> {
  final GameRepository _gameRepository = GameRepository();

  GameCubit() : super(GameState());

  static TerrainPlayer? _pickRandomPlayer(
      {List<TerrainPlayer> exclude = const []}) {
    if (exclude.length >= TerrainRules.players.length) return null;
    final randomIndex =
        Random().nextInt(TerrainRules.players.length - exclude.length);
    return TerrainRules.players
        .where((player) => !exclude.contains(player))
        .elementAt(randomIndex);
  }

  Future<TerrainPlayer> _getCurrentPlayer(
      {required List<TerrainPlayer> registeredPlayers}) async {
    final currentPlayer = await _gameRepository.getCurrentPlayer() ??
        registeredPlayers[Random().nextInt(registeredPlayers.length)];
    _gameRepository.setCurrentPlayer(currentPlayer);
    return currentPlayer;
  }

  Future<void> startGame() async {
    await _gameRepository.createGame();

    final registeredPlayers = await _gameRepository.getRegisteredPlayers();
    final newPlayer = GameCubit._pickRandomPlayer(exclude: registeredPlayers);
    if (newPlayer != null) {
      await _gameRepository.addPlayer(newPlayer);
    }
    final currentPlayer = await _getCurrentPlayer(registeredPlayers: [
      ...registeredPlayers,
      if (newPlayer != null) newPlayer
    ]);
    emit(GameState(
      status: GameStatus.started,
      currentPlayer: currentPlayer,
      localPlayer: newPlayer,
    ));
  }
}
