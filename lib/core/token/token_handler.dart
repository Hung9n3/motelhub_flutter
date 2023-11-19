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

}