import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/core/resources/search/search_model.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';

abstract class IRoomRepository {
  Future<DataState<List<RoomEntity>>> getByArea(int areaId);
  Future<DataState<RoomEntity>> getById(int roomId);
  Future<List<RoomEntity>> getAll();
  Future<DataState<List<RoomEntity>>> Search(SearchModel searchModel);
}