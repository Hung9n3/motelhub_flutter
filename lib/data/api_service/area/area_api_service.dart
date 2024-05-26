import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'area_api_service.g.dart';
@RestApi(baseUrl:areaApi)
abstract class AreaApiService {
  factory AreaApiService(Dio dio) = _AreaApiService;
  
  @GET('')
  Future<HttpResponse<List<AreaEntity>>> getAll();
}