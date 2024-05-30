import 'dart:io';

import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/data/api_service/api.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/repositories/auth_repository_interface.dart';
import 'package:dio/dio.dart';

class AuthRepository extends IAuthRepository {
  AuthRepository();
  @override
  Future<DataState> login(String username, String password) async {
    final httpResponse = await Api.login(username, password);

    if (httpResponse.response.statusCode == HttpStatus.ok) {
      return DataSuccess(httpResponse.data);
    } else {
      final response = Response(
        statusCode: httpResponse.response.statusCode,
        data: {'message': httpResponse.data},
        requestOptions: RequestOptions(path: '/api/endpoint'),
      );

      final error = DioError(
        response: response,
        requestOptions: RequestOptions(path: '/api/endpoint'),
      );

      return DataFailed(error.message);
    }
  }

  @override
  Future<DataState> register(UserEntity userEntity) async {
    final response = await Api.register(userEntity.toJson());
    var result = Api.getResult<UserEntity>(response);
    return result;
  }

  @override
  void logout() {
    // TODO: implement logout
  }

  @override
  Future<List<UserEntity>> getAll() async {
    // TODO: implement getAll
    final result = await Api.getUsers();
    return result;
  }

  @override
  Future<UserEntity?> getById(int id) async {
    // TODO: implement getById
    final result =
        (await Api.getUsers()).where((element) => element.id == id).firstOrNull;
    return result;
  }
}
