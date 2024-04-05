import 'package:api_repository/api_repository.dart';
import 'package:profile_repository/src/models/profile.dart';

class ProfileRepository {
  ProfileRepository({required this.apiRepository});
  final APIRepository apiRepository;

  Future<Profile> getProfile(String token) async {
    Map<String, dynamic> data =
        await this.apiRepository.performGet(url: '/users/me', params: {
      'language': 'pt-br'
    }, headers: {
      'Authorization': token,
    });
    return Profile.fromJson(data);
  }
}
