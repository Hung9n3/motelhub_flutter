import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'auth_api_service.g.dart';
@RestApi(baseUrl:authApi)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;
  
  @POST('/register')
  Future<HttpResponse<UserEntity>> register(@Body() UserEntity user);

  @POST('/login')
  Future<HttpResponse<String>> login(@Body() UserEntity user);
}