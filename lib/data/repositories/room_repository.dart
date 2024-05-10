import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/core/resources/search/search_model.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:dio/dio.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
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
      String? areaName = '';
      var data = RoomEntity.getFakeData()
          .firstWhere((element) => element.id == roomId);
      if (data.areaId != null) {
         areaName = AreaEntity.getFakeData()
            .where((element) => element.id == data.areaId)
            .firstOrNull
            ?.name;
      }
      var owner = UserEntity.getFakeData()
          .where((element) => element.id == data.ownerId)
          .firstOrNull;
      var contracts = ContractEntity.getFakeData().where((element) => element.roomId == data.id).toList();   
      data = RoomEntity(
          id: data.id,
          name: data.name,
          photos: data.photos,
          contracts: contracts,
          acreage: data.acreage,
          areaId: data.areaId,
          ownerName: owner?.name,
          ownerId: owner?.id,
          areaName: areaName);
      return DataSuccess(data);
    } on DioError catch (err) {
      return DataFailed(err);
    }
  }

  @override
  Future<DataState<List<RoomEntity>>> Search(SearchModel searchModel) async {
    // TODO: implement Search
    try {
      var list = RoomEntity.getFakeData();
      var data = list.getRange(1, 20).toList();
      return DataSuccess(data);
    } on DioError catch (err) {
      return DataFailed(err);
    }
  }
}
