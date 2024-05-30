import 'dart:io';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/data/api_service/api.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:dio/dio.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';

class AreaRepository extends IAreaRepository {
  AreaRepository();
  @override
  Future<DataState<List<AreaEntity>>> getByHost(int? userId) async {
    try {
      var areas = await Api.getAreas();
      var result = areas.where((element) => element.hostId == userId).toList();
      return DataSuccess(result);
    } on Exception catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<AreaEntity>> getById(int id) async {
    var listData = AreaEntity.getFakeData();
    var result = listData.where((element) => element.id == id).firstOrNull;
    return DataSuccess(result);
  }

  @override
  Future<DataState<List<AreaEntity>>> getAll() async {
    var areas = await Api.getAreas();
    var result = Api.getResult<List<AreaEntity>>(areas);
    return result;
  }

  @override
  Future<DataState<List<AreaEntity>>> getByCustomer(int? userId) async {
    try {
      var contract = await Api.getContracts();
      var contractByCustomer =
          contract.where((element) => element.customerId == userId).toList();
          if(contractByCustomer.isEmpty) {
            return const DataSuccess([]);
          }
      var areas = await Api.getAreas();
      var rooms = await Api.getRooms();
      var areaIds = rooms
          .where((element) =>
              contractByCustomer.map((e) => e.roomId).contains(element.id))
          .map((e) => e.areaId);
      var result =
          areas.where((element) => areaIds.contains(element.id)).toList();
      return DataSuccess(result);
    } on Exception catch (e) {
      return DataFailed(e.toString());
    }
  }
  
  @override
  Future<DataState> save(AreaEntity entity) async {
    try {
      var response = await Api.post(entity.toJson(), 'Area');
      var result = Api.getResult<bool>(response);
      return result;
    } on Exception catch (e) {
      return DataFailed(e.toString());
    }
  }
}
