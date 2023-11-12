import 'package:api_repository/api_repository.dart';
import 'package:games_repository/src/models/game.dart';

class GamesRepository {
  GamesRepository({required this.apiRepository});
  final APIRepository apiRepository;

  Future<List<Game>> getGames(String token) async {
    List<dynamic> data = await apiRepository.performGet('/get_stats',  {'token': token, 'language': 'pt-br'});
    return data.map((e) => Game.fromJson(e)).toList();
  }
}