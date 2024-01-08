import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/bases/meter_reading.dart';
import 'package:motelhub_flutter/domain/entities/electric.dart';
import 'package:motelhub_flutter/domain/entities/water.dart';
import 'package:motelhub_flutter/domain/repositories/meter_reading_repository_interface.dart';

class MeterReadingRepository extends IMeterReadingRepository{
  @override
  Future<DataState<MeterReadingEntity>> getById(int? id, MeterReadingType? type) async {
    // TODO: implement getById api
    switch(type) {
      case MeterReadingType.water: 
        var data = WaterEntity.getFakeData().where((element) => element.id == id).firstOrNull;
        if(data != null) {
          return DataSuccess(data);
        }
        else {
          return DataSuccess(data);
        }
      default: 
        var data = ElectricEntity.getFakeData().where((element) => element.id == id).firstOrNull;
        if(data != null) {
          return DataSuccess(data);
        }
        else {
          return DataSuccess(data);
        }
    }
  }
  
  @override
  Future<DataState<MeterReadingEntity>> submit(MeterReadingEntity entity, MeterReadingType? type) async {
    // TODO: implement submit api
    print(entity);
    return DataSuccess(entity);
  }

}