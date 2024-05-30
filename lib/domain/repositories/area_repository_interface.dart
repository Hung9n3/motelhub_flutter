import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';

abstract class IAreaRepository {
  Future<DataState<List<AreaEntity>>> getByHost(int? userId);
  Future<DataState<List<AreaEntity>>> getByCustomer(int? userId);
  Future<DataState<List<AreaEntity>>> getAll();
  Future<DataState<AreaEntity>> getById(int id);
  Future<DataState> save(AreaEntity entity);
}