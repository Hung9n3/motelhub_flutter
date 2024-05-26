import 'dart:io';

import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/repositories/auth_repository_interface.dart';
import 'package:motelhub_flutter/data/context/api_service_context.dart';
import 'package:dio/dio.dart';

class AuthRepository extends IAuthRepository {
  final ApiServiceContext  context; 
  AuthRepository(this.context);
  @override
  Future<DataState> login(String username, String password) async {
    final httpResponse = await context.auth.login(
      UserEntity(username: username, password: password)
    );

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

      return DataFailed(error);
    }
  }

  @override
  Future<DataState> register(UserEntity userEntity) async {
    final httpResponse = await context.auth.login(
      userEntity
    );

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

      return DataFailed(error);
    }
  }

  @override
  void logout() {
    // TODO: implement logout
  }
}
