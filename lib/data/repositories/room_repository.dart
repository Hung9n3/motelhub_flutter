import 'dart:convert';

import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/core/resources/search/search_model.dart';
import 'package:motelhub_flutter/data/api_service/api.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:dio/dio.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';

class RoomRepository extends IRoomRepository {
  @override
  Future<List<RoomEntity>> getByArea(int areaId) async {
    try {
      var rooms = await Api.getRooms();
      return rooms;
    } on Exception catch (err) {
      rethrow;
    }
  }

  @override
  Future<DataState<RoomEntity>> getById(int roomId) async {
    // TODO: implement getById api
    try {
      var rooms = await Api.getRooms();
      var result = rooms.where((element) => element.id == roomId).firstOrNull;
      if(result == null) {
        return const DataFailed('Not Found');
      }
      return DataSuccess(result);
    } on Exception catch (err) {
      return DataFailed(err.toString());
    }
  }

  @override
  Future<DataState<List<RoomEntity>>> Search(SearchModel searchModel) async {
    // TODO: implement Search
    try {
      var list = RoomEntity.getFakeData();
      var data = list.getRange(1, 20).toList();
      return DataSuccess(data);
    } on Exception catch (err) {
      return DataFailed(err.toString());
    }
  }
  
  @override
  Future<List<RoomEntity>> getAll() async {
    var result = await Api.getRooms();
    return result;
  }
  
  @override
  Future<DataState> save(RoomEntity room) async {
    var response = await Api.post(jsonEncode(room.toJson()), 'Room');
    var result = Api.getResult(response);
    for(var photo in room.photos ?? []) {
      if(photo.roomId !=null || photo.roomId != 0) {
        continue;
      }
      photo.roomId = int.parse(result.data);
      PhotoEntity.photos.add(photo);
    }
    return result;
  }
}
