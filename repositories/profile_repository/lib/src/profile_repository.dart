import 'package:api_repository/api_repository.dart';
import 'package:profile_repository/src/models/profile.dart';
class ProfileRepository {
  ProfileRepository({required this.apiRepository});
  final APIRepository apiRepository;

  Future<Profile> getProfile() async {
    Map<String, dynamic> data = await this.apiRepository.performGet('/get_own_info', {'token': '7RKddfBJ1xU8USlcUwJSkFalvXP9nRCRu1A3ytXLvorqGxy22Cb7cpVpOuqmk34i', 'language': 'pt-br'});
    return Profile.fromJson(data);
  }
}