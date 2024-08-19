import 'package:get_storage/get_storage.dart';

class TokenStorage {
  final GetStorage _storage = GetStorage();

  final String _tokenKey = 'Token';
  final String _refreshTokenKey='Rtoken';

  void saveToken(String token) {
    _storage.write(_tokenKey, token);
    print('Token saved: $token');
  }

  String? getToken() {
    String? token = _storage.read(_tokenKey);
    print('Retrieved token: $token');
    return token;
  }

  void deleteToken() {
    _storage.remove(_tokenKey);
    print('Token deleted');
  }
  void saveRToken(String token) {
    _storage.write(_refreshTokenKey, token);
    print('Token saved: $token');
  }

  String? getRToken() {
    String? token = _storage.read(_refreshTokenKey);
    print('Retrieved token: $token');
    return token;
  }

  void deleteRToken() {
    _storage.remove(_refreshTokenKey);
    print('Token deleted');
  }
}