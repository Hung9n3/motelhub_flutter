import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/boarding_house_area.dart';

abstract class IBoardingHouseAreaRepository {
  Future<DataState<List<BoardingHouseAreaEntity>>> getByUser(String username);
}