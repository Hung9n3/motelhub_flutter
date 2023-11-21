import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/boarding_house_area.dart';
import 'package:motelhub_flutter/domain/repositories/boarding_house_area_repository_interface.dart';

class BoardingHouseAreaRepository extends IBoardingHouseAreaRepository{
  @override
  Future<DataState<List<BoardingHouseAreaEntity>>> getByUser(String username) async {
    // TODO: implement getByUser api
    var listData = BoardingHouseAreaEntity.getFakeData();
    var data = listData.where((element) => element.owner == username).toList();
    return DataSuccess(data);
  }

}