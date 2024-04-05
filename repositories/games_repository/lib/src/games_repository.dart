import 'package:api_repository/api_repository.dart';
import 'package:games_repository/src/models/game.dart';

class GamesRepository {
  GamesRepository({required this.apiRepository});
  final APIRepository apiRepository;

  Future<List<Game>> getGames(String token) async {
    List<dynamic> data = await apiRepository.performGet(
        url: '/games',
        params: {'language': 'pt-br'},
        headers: {'Authorization': token});
    return data.map((e) => Game.fromJson(e)).toList();
  }
}
