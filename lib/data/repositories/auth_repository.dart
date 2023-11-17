import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/repositories/auth_repository_interface.dart';
import 'package:dio/dio.dart';

class AuthRepository extends IAuthRepository {
  @override
  Future<DataState> login(String username, String password) async {
    // TODO: implement login using api
    if (username == 'hung' && password == '123') {
      return DataSuccess(username);
    } else {
      final response = Response(
        statusCode: 404,
        data: {'message': 'Not Found'},
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
