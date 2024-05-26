import 'dart:io';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/data/api_service/api.dart';
import 'package:motelhub_flutter/data/context/api_service_context.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:dio/dio.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';

class AreaRepository extends IAreaRepository{
  final ApiServiceContext context;
  AreaRepository(this.context);
  @override
  Future<DataState<List<AreaEntity>>> getByUser(int? userId) async {
    // final httpResponse = await context.area.getAll();
    // if (httpResponse.response.statusCode == HttpStatus.ok) {
    //   var areas = httpResponse.data;
    //   var areaByUsers = areas.where((element) => element.hostId == userId).toList();
    //   return DataSuccess(areaByUsers);
    // } else {
    //   final response = Response(
    //     statusCode: httpResponse.response.statusCode,
    //     data: {'message': httpResponse.data},
    //     requestOptions: RequestOptions(path: '/api/endpoint'),
    //   );

    //   final error = DioError(
    //     response: response,
    //     requestOptions: RequestOptions(path: '/api/endpoint'),
    //   );

    //   return DataFailed(error);
    // }
    return DataSuccess(await Api.getAreas());
  }
  
  @override
  Future<DataState<AreaEntity>> getById(int id) async {
    // TODO: implement getById
    var listData = AreaEntity.getFakeData();
    var data = listData.where((element) => element.id == id).firstOrNull;
    return DataSuccess(data!);
  }

}