import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';

abstract class IAuthRepository {
  Future<DataState> login(String username, String password);
  Future<DataState> register(UserEntity userEntity);
  Future<UserEntity?> getById(int id);
  Future<List<UserEntity>> getAll();
  void logout();
}
