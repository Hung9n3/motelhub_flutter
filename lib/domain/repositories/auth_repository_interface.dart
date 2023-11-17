import 'package:motelhub_flutter/core/resources/data_state.dart';

abstract class IAuthRepository {
  Future<DataState> login(String username, String password);
  void logout();
} 