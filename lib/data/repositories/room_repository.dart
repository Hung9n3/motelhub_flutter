import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:dio/dio.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';

class RoomRepository extends IRoomRepository {
  @override
  Future<DataState<List<RoomEntity>>> getByArea(int areaId) async {
    try {
      // TODO: implement getByArea api
      var list = RoomEntity.getFakeData();
      var data = list.where((element) => element.areaId == areaId).toList();
      return DataSuccess(data);
    } on DioError catch (err) {
      return DataFailed(err);
    }
  }

  @override
  Future<DataState<RoomEntity>> getById(int roomId) async {
    // TODO: implement getById api
    try {
      var data = RoomEntity.getFakeData()
          .firstWhere((element) => element.id == roomId);

      var areaName = AreaEntity.getFakeData()
          .firstWhere((element) => element.id == data.areaId)
          ?.name;
      data = RoomEntity(
          id: data.id,
          name: data.name,
          photos: data.photos,
          acreage: data.acreage,
          areaId: data.areaId,
          areaName: areaName);
      return DataSuccess(data);
    } on DioError catch (err) {
      return DataFailed(err);
    }
  }
}
