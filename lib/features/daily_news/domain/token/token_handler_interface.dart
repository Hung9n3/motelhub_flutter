
abstract class ITokenHandler{
  Future<void> write(String key, String value);
  Future<void> update(String key, String value);
  Future<void> delete(String key);
  Future<String> getByKey(String key);
  Map<String,dynamic> decodeToken(String token);
}