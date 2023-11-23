import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';

abstract class IRoomRepository {
  Future<DataState<List<RoomEntity>>> getByArea(int areaId);
}