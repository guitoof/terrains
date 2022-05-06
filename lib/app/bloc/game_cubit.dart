import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrains/data/repositories/game_repository.dart';
import 'package:terrains/domain/entities/terrains_game.dart';

enum GameState { notStarted, started }

class GameCubit extends Cubit<GameState> {
  final GameRepository _gameRepository = GameRepository();

  GameCubit() : super(GameState.notStarted);

  Future<void> startGame(int width, int height) async {
    final game = TerrainsGame(width: width, height: height);
    return _gameRepository.startGame(game);
  }
}
