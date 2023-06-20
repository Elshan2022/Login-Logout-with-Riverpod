import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheManager {
  saveToken(String token) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: CacheEnum.token.toString(), value: token);
  }

  Future<String?> getToken() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: CacheEnum.token.toString());
  }

  deleteToken() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: CacheEnum.token.toString());
  }
}

enum CacheEnum { token }
