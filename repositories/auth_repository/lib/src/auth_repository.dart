import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  AuthRepository() {
    storage = FlutterSecureStorage();
  }
  late FlutterSecureStorage storage;
  Future<void> saveToken(String token) async {
    await storage.write(key: "ssoToken", value: token);
  }

  Future<bool> checkToken() async {
    final token = await storage.read(key: "ssoToken");
    return token != null;
  }

  Future<String> getToken() async {
    final token = await storage.read(key: "ssoToken");
    if (token == null) return "";
    return token;
  }

  Future<void> clearToken() async {
    await storage.delete(key: "ssoToken");
  }
}