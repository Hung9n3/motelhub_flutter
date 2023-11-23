import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';

class RoomRepository extends IRoomRepository {
  @override
  Future<DataState<List<RoomEntity>>> getByArea(int areaId) async {
    // TODO: implement getByArea api
    var list = RoomEntity.getFakeData();
    var data = list.where((element) => element.areaId == areaId).toList();
    return DataSuccess(data);
  }
}
