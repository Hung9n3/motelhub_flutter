import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';

class AreaRepository extends IAreaRepository{
  @override
  Future<DataState<List<AreaEntity>>> getByUser(String username) async {
    // TODO: implement getByUser api
    var listData = AreaEntity.getFakeData();
    var data = listData.where((element) => element.owner == username).toList();
    return DataSuccess(data);
  }
  
  @override
  Future<DataState<AreaEntity>> getById(int id) async {
    // TODO: implement getById
    var listData = AreaEntity.getFakeData();
    var data = listData.where((element) => element.id == id).firstOrNull;
    return DataSuccess(data!);
  }

}