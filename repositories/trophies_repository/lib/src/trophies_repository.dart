import 'package:api_repository/api_repository.dart';
import 'package:trophies_repository/src/models/trophy.dart';
import 'package:trophies_repository/src/models/trophy_group.dart';

class TrophiesRepository {
  TrophiesRepository({required this.apiRepository});
  final APIRepository apiRepository;

  Future<List<TrophyGroup>> getTrophyGroups(String titleId, String token) async {
    Map<String, dynamic> data = await apiRepository.performGet("/get_trophy_groups/$titleId", {'token': token, 'language': 'pt-br'});
    final groups = data['groups'].map<TrophyGroup>((e) => TrophyGroup.fromJson(e) as TrophyGroup).toList();
    return groups;
  }

  Future<List<Trophy>> getTrophies(String titleId, String groupId, String token) async {
    dynamic data = await apiRepository.performGet("/get_trophies/$titleId/$groupId", {'token': token, 'language': 'pt-br'});
    final trophies = data.map<Trophy>((e) => Trophy.fromJson(e)).toList();
    return trophies;
  }
}