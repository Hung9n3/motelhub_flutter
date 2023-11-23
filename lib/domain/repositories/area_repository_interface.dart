import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';

abstract class IAreaRepository {
  Future<DataState<List<AreaEntity>>> getByUser(String username);
  Future<DataState<AreaEntity>> getById(int id);
}