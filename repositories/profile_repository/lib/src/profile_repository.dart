import 'package:api_repository/api_repository.dart';
import 'package:profile_repository/src/models/profile.dart';
class ProfileRepository {
  ProfileRepository({required this.apiRepository});
  final APIRepository apiRepository;

  Future<Profile> getProfile(String token) async {
    Map<String, dynamic> data = await this.apiRepository.performGet('/get_own_info', {'token': token, 'language': 'pt-br'});
    return Profile.fromJson(data);
  }
}