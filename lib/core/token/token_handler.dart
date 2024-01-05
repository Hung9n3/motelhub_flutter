import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:motelhub_flutter/features/daily_news/domain/token/token_handler_interface.dart';

class TokenHandler extends ITokenHandler{

  final FlutterSecureStorage secureStorage;
  TokenHandler(this.secureStorage);

  @override
  Future<void> delete(String key) async {
    await secureStorage.delete(key: key);
  }

  @override
  Future<String> getByKey(String key) async {
    var result = await secureStorage.read(key: key);
    result ??= '';
    return result.toString();
  }

  @override
  Future<void> write(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }
  
  @override
  Future<void> update(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }
  
  @override
  Map<String,dynamic> decodeToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}