import 'package:api_repository/api_repository.dart';
import 'package:games_repository/src/models/game.dart';

class GamesRepository {
  GamesRepository({required this.apiRepository});
  final APIRepository apiRepository;

  Future<List<Game>> getGames() async {
    List<dynamic> data = await apiRepository.performGet('/get_stats',  {'token': '7RKddfBJ1xU8USlcUwJSkFalvXP9nRCRu1A3ytXLvorqGxy22Cb7cpVpOuqmk34i', 'language': 'pt-br'});
    return data.map((e) => Game.fromJson(e)).toList();
  }
}