import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/bases/meter_reading.dart';

abstract class IMeterReadingRepository<T extends MeterReadingEntity> {
  Future<DataState<T>> getById(int? id, MeterReadingType type);
}